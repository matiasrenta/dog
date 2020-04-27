class ProductBoxesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_box_params

  # GET /product_boxes
  def index
    @product_boxes = indexize(ProductBox)
  end

  # GET /product_boxes/1
  def show
  end

  # GET /product_boxes/new
  def new
  end

  # GET /product_boxes/1/edit
  def edit
  end

  # POST /product_boxes
  def create
    if @product_box.save
      redirect_to @product_box, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@product_box)
      render :new
    end
  end

  # PATCH/PUT /product_boxes/1
  def update
    if @product_box.update(product_box_params)
      redirect_to @product_box, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@product_box)
      render :edit
    end
  end

  # DELETE /product_boxes/1
  def destroy
    if @product_box.destroy
      redirect_to product_boxes_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@product_box)
      redirect_to product_boxes_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def product_box_params
      params.require(:product_box).permit(:product_id, :code, :name, :quantity)
    end
end
