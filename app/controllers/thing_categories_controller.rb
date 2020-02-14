class ThingCategoriesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :thing_category_params

  # GET /thing_categories
  def index
    @thing_categories = indexize(ThingCategory)
  end

  # GET /thing_categories/1
  def show
  end

  # GET /thing_categories/new
  def new
  end

  # GET /thing_categories/1/edit
  def edit
  end

  # POST /thing_categories
  def create
    if @thing_category.save
      redirect_to @thing_category, notice: t("simple_form.flash.successfully_created") if request.format != :js
    else
      if request.format == :js # esto es por si viene creado desde un modal via ajax de otra entidad (desde Thing en este caso)
        @html_form = render_to_string('_form_remote.html.erb', layout: false, formats: [:html] )
        render :new, formats: [:js]
      else
        generate_flash_msg_no_keep(@thing_category)
        render :new
      end
    end
  end

  # PATCH/PUT /thing_categories/1
  def update
    if @thing_category.update(thing_category_params)
      redirect_to @thing_category, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@thing_category)
      render :edit
    end
  end

  # DELETE /thing_categories/1
  def destroy
    if @thing_category.destroy
      redirect_to thing_categories_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@thing_category)
      redirect_to :back
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def thing_category_params
      params.require(:thing_category).permit(:name)
    end
end
