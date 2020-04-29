class ProductsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_params

  # GET /products
  def index
    @products = do_index(Product, params)
  end

  # GET /products/1
  def show
    @product_prices = indexize(ProductPrice, collection: @product.product_prices)
    @product_boxes = indexize(ProductPrice, collection: @product.product_boxes, query_param: :q_box)
  end

  # GET /products/new
  def new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    if @product.save
      redirect_to @product, notice: t("simple_form.flash.successfully_created")
    else
      puts @product.errors.messages
      generate_flash_msg_no_keep(@product)
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@product)
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    if @product.destroy
      redirect_to products_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@product)
      redirect_to products_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:code, :name, :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :saleman_fee_percent, :units_sale_allowed, :is_mix_box,
                                      {product_prices_attributes: [:id, :price]},
                                      {product_boxes_attributes: [:_destroy, :id, :code, :name, :quantity]},
                                      {product_mix_boxes_attributes: [:_destroy, :id, :product_id, :quantity]})
    end
end
