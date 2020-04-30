class BoxesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :box_params

  # GET /boxes
  def index
    @boxes = indexize(Box)
  end

  # GET /boxes/1
  def show
  end

  # GET /boxes/new
  def new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  def create
    if @box.save
      redirect_to @box, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@box)
      render :new
    end
  end

  # PATCH/PUT /boxes/1
  def update
    if @box.update(box_params)
      redirect_to @box, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@box)
      render :edit
    end
  end

  # DELETE /boxes/1
  def destroy
    if @box.destroy
      redirect_to boxes_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@box)
      redirect_to boxes_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def box_params
      params.require(:box).permit(:name, :quantity)
    end
end
