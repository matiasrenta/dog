module ApplicationHelper

  def options_for_boolean
    [[t('true'), 'true'], [t('false'), 'false']]
  end

  def boolean_check_mark(boo)
    if boo
      '<i class="fa fa-check"></i>'.html_safe
    else
      ''
    end
  end

  def creating?
    ["new", "create"].include?(action_name)
  end

  def updating?
    ["edit", "update"].include?(action_name)
  end

  def listing?
    action_name == "index"
  end

  def showing?
    action_name == "show"
  end

  # def link_to_add_fields(name, f, association)
  #   #new_object = f.object.send(association).klass.new
  #   hash = {name: nil, type: nil, i18n_name: nil, formats: nil, validations: nil, association: nil}
  #   new_object = OpenStruct.new(hash)
  #   id = new_object.object_id
  #   fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
  #     hash.keys.each do |field_name|
  #       render(association.to_s.singularize + "_fields", f: builder, field_name: field_name)
  #     end
  #   end
  #   link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  # end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def format_date_field(var)
    var ? var.strftime("%d/%m/%Y") : nil
  end

  def format_datetime_field(var)
    var ? var.strftime("%d/%m/%Y %H:%M") : nil
  end

  def edit_model_path(instance)
    eval("edit_#{instance.class.name.underscore}_path(instance)")
  end

  def friendly_file_size(bytes)
    return nil if bytes.nil?
    b = Float(bytes)
    if b > 1073741824 # Gb
      "#{(b / 1073741824).round(1)} Gb."
    elsif b > 1048576 # Mb
      "#{(b / 1048576).round(1)} Mb."
    elsif b > 1024    # Kb
      "#{(b / 1024).round} Kb."
    else              # bytes
      "#{bytes} Bytes"
    end
  end

  def titled_time_ago_in_words(date_or_datetine, options = {})
    return nil if date_or_datetine.blank?
    formated_time_value = l(date_or_datetine, format: options[:format] || :without_seg)
    "<span title=\"#{formated_time_value}\">#{time_ago_in_words(date_or_datetine, options)}</span>".html_safe
  end

  # para no mostrar los usuarios superusers a los que no son superusers
  def users_hide_or_show_superusers
    if current_user.superuser?
      User.all
    else
      User.less_superusers
    end
  end

end
