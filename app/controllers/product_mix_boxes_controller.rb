class ProductMixBoxesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_mix_box_params

  # GET /product_mix_boxes
  def index
    @product_mix_boxes = indexize(ProductMixBox)
  end

  # GET /product_mix_boxes/1
  def show
  end

  # GET /product_mix_boxes/new
  def new
  end

  # GET /product_mix_boxes/1/edit
  def edit
  end

  # POST /product_mix_boxes
  def create
    if @product_mix_box.save
      redirect_to @product_mix_box, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@product_mix_box)
      render :new
    end
  end

  # PATCH/PUT /product_mix_boxes/1
  def update
    if @product_mix_box.update(product_mix_box_params)
      redirect_to @product_mix_box, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@product_mix_box)
      render :edit
    end
  end

  # DELETE /product_mix_boxes/1
  def destroy
    if @product_mix_box.destroy
      redirect_to product_mix_boxes_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@product_mix_box)
      redirect_to product_mix_boxes_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def product_mix_box_params
      params.require(:product_mix_box).permit(:mix_box_id, :product_id, :quantity)
    end
end
