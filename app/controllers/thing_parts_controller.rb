class ThingPartsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :thing_part_params

  # GET /thing_parts
  def index
    params[:q] = {name_cont: params[:term]} if params[:term].present?
    @thing_parts = indexize(ThingPart)
  end

  # GET /thing_parts/1
  def show
  end

  # GET /thing_parts/new
  def new
  end

  # GET /thing_parts/1/edit
  def edit
  end

  # POST /thing_parts
  def create
    if @thing_part.save
      redirect_to @thing_part, notice: t("simple_form.flash.successfully_created") if request.format != :js
    else
      if request.format == :js # esto es por si viene creado desde un modal via ajax de otra entidad (desde Thing en este caso)
        @html_form = render_to_string('_form_remote.html.erb', layout: false, formats: [:html] )
        render :new, formats: [:js]
      else
        generate_flash_msg_no_keep(@thing_part)
        render :new
      end
    end
  end

  # PATCH/PUT /thing_parts/1
  def update
    if @thing_part.update(thing_part_params)
      redirect_to @thing_part, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@thing_part)
      render :edit
    end
  end

  # DELETE /thing_parts/1
  def destroy
    if @thing_part.destroy
      redirect_to thing_parts_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@thing_part)
      redirect_to :back
    end
  end


  private

    # Only allow a trusted parameter "white list" through.
    def thing_part_params
      params.require(:thing_part).permit(:name, :field1, :field2, :field3)
    end
end
