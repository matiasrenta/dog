class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  check_authorization unless: :not_check_authorization?
  skip_authorization_check only: [:access_denied]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cache_buster
  before_action :authenticate_user!
  before_action :set_content_title, :unread_notifications_count, :set_user_time_zone#, :set_user_language,
  before_action :set_last_seen_at, if: proc { user_signed_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 15.minutes.ago) }
  before_action :set_paper_trail_whodunnit

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def access_denied
    set_content_title(nil, [''])
  end

  def raise_not_found!
      raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def download_import_file
    respond_to do |format|
      format.xlsx{response.headers['Content-Disposition'] = "attachment; filename=#{import_file_name}.xlsx"}
    end
  end

  def new_import
    authorize! :import, model_class
    set_content_title(icon_class, [t("activerecord.models.#{controller_name.singularize}", count: 2), t("activerecord.actions.import")])
    @entity_import = model_import_class.new
  end

  # example: create_import(Thing, ThingImport, 'fa-fw fa fa-cube')
  def create_import
    authorize! :import, model_class
    set_content_title(icon_class, [t("activerecord.models.#{controller_name.singularize}", count: 2), t("activerecord.actions.import")])
    @entity_import = model_import_class.new(params["#{model_class.name.underscore}_import".to_sym])
    if @entity_import.save
      redirect_to eval("#{model_class.name.underscore.pluralize}_url"), notice: t('activerecord.messages.imported_successfuly', count: @entity_import.imported_entities.size)
    else
      generate_flash_msg_no_keep(@entity_import)
      render :new_import
    end
  end


  protected ####################################### PROTECTED ###################################################

  def unread_notifications_count
    @unread_notifications_count = unread_notifications.count if user_signed_in?
  end

  def set_content_title(icon = nil, title = nil)
    if title.nil?
      if action_name == "index"
        title = [t("activerecord.models.#{controller_name.singularize}", count: 2)]
      else
        title = [t("activerecord.models.#{controller_name.singularize}", count: 1), t("activerecord.actions.#{action_name}")]
      end
    end
    icon = t("activerecord.models.#{controller_name.singularize}.fa_icon", default: '') if icon.nil?
    @content_title = Hash.new
    @content_title[:title] = title[0] if title.size == 1
    @content_title[:title] = "#{title[0]} <span>> #{title[1]} </span>" if title.size == 2
    @content_title[:icon]  = icon
  end

  def set_user_language
    I18n.locale = (user_signed_in? && !current_user.locale.blank?) ? current_user.locale.to_sym : I18n.default_locale
  end

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in? && !current_user.time_zone.blank?
  end

  # options:
  #   collection: la collección que debe ser "indexada" (no usará el model par obtener los datos)
  #   no_paginate: true/false. default to false
  #   order: texto para hacer el order by (o bien un symbol. Será ordenado por defecto (ASC o DESC no recuerdo))
  #   includes: texto para hacer includes. CUIDADO: si hago un include de una tabla que es has_many para el modelo a indexar, pueden venir registros duplicados (Thing.includes(:thing_parts))
  #   query_param: si se necesita enviar el parametro ransack distinto a :q (para el caso de multiples listas en una misma pagina)
  def indexize(model, options = {})
    authorize!(:read, model)
    query_param = options[:query_param] || :q
    collection = options[:collection] || model
    search_algoritm(query_param)
    if params[query_param] && params[query_param][:meta_sort]
      instance_variable_set("@#{query_param}", collection.accessible_by(current_ability, :read).ransack(params[query_param]))
    elsif options[:order]
      instance_variable_set("@#{query_param}", collection.order(options[:order]).accessible_by(current_ability, :read).ransack(params[query_param])) unless options[:includes]
      instance_variable_set("@#{query_param}", collection.includes(options[:includes]).order(options[:order]).accessible_by(current_ability, :read).ransack(params[query_param])) if options[:includes]
    else
      instance_variable_set("@#{query_param}", collection.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :read).ransack(params[query_param]))
    end

    #indexize_collection = eval("@#{query_param}.result(distinct: true)")
    indexize_collection = eval("@#{query_param}.result") # TODO: si existiera option[:includes] hay que pensar como se hace: includes(:articles).page(params[:page]).to_a.uniq

    if options[:no_paginate]
      indexize_collection.all
    else
      indexize_collection.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
    end
  end

  # <b>DEPRECATED:</b> Please use <tt>indexize</tt> instead.
  def do_index(model, params, collection = nil, paginate = true, order_by = nil, includes = nil, query_param = :q)
    authorize!(:read, model)
    variable_name = query_param.to_s
    search_algoritm(query_param)
    if params[query_param] && params[query_param][:meta_sort]
      instance_variable_set("@#{variable_name}", model.accessible_by(current_ability, :read).ransack(params[query_param]))
    elsif order_by
      instance_variable_set("@#{variable_name}", model.order(order_by).accessible_by(current_ability, :read).ransack(params[query_param])) unless includes
      instance_variable_set("@#{variable_name}", model.includes(includes).order(order_by).accessible_by(current_ability, :read).ransack(params[query_param])) if includes
    else
      instance_variable_set("@#{variable_name}", model.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :read).ransack(params[query_param]))
    end

    model_collection = eval("@#{variable_name}.result(distinct: true)") #@q.result(distinct: true)
    if paginate
      model_collection.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
    else
      model_collection.all
    end
  end

  def search_algoritm(query_param = :q)
    if params[:search_clear]
      params[query_param] = nil
      params[:search_clear] = nil
    end
    if params[query_param]
      params[query_param].each do |param|
        unless param[1].blank? || param[0] == 's' # la 's' es para que no se ponga rojo cuando solo se hace sort de columnas
          instance_variable_set("@#{query_param.to_s}_filter_active", true) # ejemplo: @q_obra_filter_active
          @filter_active = true;
          break
        end
      end
    end
  end

  #def search_algoritm
  #  if params[:search_clear]
  #    params[:q] = nil
  #    params[:search_clear] = nil
  #  end
  #  if params[:q]
  #    params[:q].each do |param|
  #      unless param[1].blank? || param[0] == 's' # la 's' es para que no se ponga rojo cuando solo se hace sort de columnas
  #        @filter_active = true;
  #        break
  #      end
  #    end
  #  end
  #end

  def per_page(quantity)
    if !quantity.blank?
      cookies[:per_page] = {:value => quantity, :expires => 30.days.from_now}
    elsif cookies[:per_page].blank?
      cookies[:per_page] = {:value => "20", :expires => 30.days.from_now} #default 20 per page
    end
    params[:per_page] = cookies[:per_page]
    cookies[:per_page]
  end

  def generate_flash_msg(model_instance, flash_type = :alert)
    if model_instance.errors.messages[:base].present?
      flash[flash_type] = model_instance.errors.get(:base).kind_of?(String) ? model_instance.errors.get(:base) : model_instance.errors.get(:base).join(". ")
    elsif model_instance.errors.any?
      flash[flash_type] = t('activerecord.errors.template.default_error_base')
      #puts "@@@@@@@@@@@@@@@@@@ model_instance.errors.full_messages: #{model_instance.errors.full_messages}"
    end
  end

  def generate_flash_msg_no_keep(model_instance, flash_type = :alert)
    generate_flash_msg(model_instance, flash_type)
    flash.discard(flash_type) # elimina esta entrada del flash al finalizar el action
  end

  private ############################################ PRIVATE #################################################

  def prudent_destroy(instance, options = nil)
    #opt = options || {}
    #if instance.respond_to?(:really_destroy!)
    #  if instance.really_destroy!
    #    redirect_to opt[:redirect_to] || eval("#{instance.class.name.underscore.pluralize}_path"), notice: t("simple_form.flash.successfully_destroyed")
    #  else
    #    generate_flash_msg(instance)
    #    if instance.errors.count == 1 && flash[:alert].to_s.include?('restrict_dependent_destroy')
    #      instance.errors.clear
    #      # elimino el public activity porque Paranoia equivocamente lo crea
    #      PublicActivity::Activity.where(trackable_id: instance.id, trackable_type: instance.class.name, key: "#{instance.class.name.underscore}.destroy").order(:id).last.destroy
    #      if instance.update_column(:deleted_at, Time.now) # update_column no lanza los callbacks de update
    #        # todo: ejecutar el metodo llamado run_callbacks_destroy de la instancia: instance.try(:run_callbacks_destroy)
    #        # ese metodo será publico y podrá acceder a los privados que son los del verdader callback
#
    #        #instance.run_callbacks(:destroy) { instance.update_column(:deleted_at, Time.now) } # esto hubiera sido lo optimo, pero se corta por el restrict_dependent_destroy
    #        # creo un custom public activity de inactivate
    #        instance.create_activity(key: "#{instance.class.name.underscore}.inactivate", owner: current_user)
    #        flash[:alert] = nil
    #        flash[:info] = 'Se hizo soft delete'
    #      end
    #    end
    #    redirect_to :back
    #  end
    #else
    #  if instance.destroy
    #    redirect_to opt[:redirect_to] || eval("#{instance.class.name.underscore.pluralize}_path"), notice: t("simple_form.flash.successfully_destroyed")
    #  else
    #    generate_flash_msg(instance)
    #    redirect_to :back
    #  end
    #end
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end

  #continue to use rescue_from in the same way as before
  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from ActionController::RoutingError, :with => :render_404
  #end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/application/access_denied", alert: t("helpers.messages.access_denied")
  end
  rescue_from CanCan::AuthorizationNotPerformed do |exception|
    raise CanCan::AuthorizationNotPerformed
  end

  def render_404(exception)
    #set_content_title(t("screens.errors.not_found_404"))
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'error', status: 404 }
      format.all { render :nothing => true, :status => 404 }
    end
  end

  def render_500(exception)
    #set_content_title(t("screens.errors.internal_server_error_500"))
    @msg = exception.message + " -- Clase: "
    @backtrace_html = exception.backtrace.join("<br/>")
    backtrace_log = exception.backtrace.join("\n")
    logger.info @msg
    logger.info backtrace_log
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'error', status: 500 }
      format.all { render :nothing => true, :status => 500 }
    end
    ExceptionNotifier.notify_exception(exception, :env => request.env) #para que me notifique por mail en production
  end

  # del nombre del controller obtengo el model, ej: de things_controller obtengo Thing (no el string sino la clase)
  def model_class
    eval("#{controller_name.singularize.camelize}")
  end

  def model_import_class
    eval("#{model_class.name}Import")
  end

  def import_file_name
    "#{t("activerecord.models.#{controller_name.singularize}.other").tr(' ', '_')}_import"
  end

  def icon_class
    t("activerecord.models.#{controller_name.singularize}.fa_icon")
  end

  # cuento las notificaciones del current_user para mostrar en el header
  def unread_notifications
    Mailboxer::Receipt.where(mailbox_type: 'inbox',
                            receiver_id: current_user.id,
                            is_read: false,
                            trashed: false,
                            deleted: false) if user_signed_in?
  end

  def set_last_seen_at
    time_now = Time.now
    current_user.update_attribute(:last_seen_at, time_now)
    session[:last_seen_at] = time_now
  end

  def not_check_authorization?
    devise_controller? || is_a?(Select2AutocompletesController)
  end

end
