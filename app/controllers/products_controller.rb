class ProductsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_params

  # GET /products
  def index
    @products = do_index(Product, params)
  end

  # GET /products/1
  def show
    @product_prices = indexize(ProductPrice, collection: @product.product_prices)
    @product_boxes = indexize(ProductBox, collection: @product.product_boxes, query_param: :q_box)
    @mix_box_details = indexize(MixBoxDetail, collection: @product.mix_box_details, query_param: :q_mix_box)
  end

  # GET /products/new
  def new
    # para que aparezcan en el form hago build de los precios
    #CustomerCategory.all.each do |cc|
      #@product.product_prices.build(customer_category_id: cc.id, profit_percent: cc.profit_percent)
    #end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    if @product.save
      #format.html { redirect_to(@therapist); flash[:info] = "Ingrese los rangos horarios en que trabaja este terapeuta" }
      flash[:info] = t('simple_form.flash.info.check_prices')
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
      params.require(:product).permit(:code, :name, :product_brand_id, :product_cost, :cargo_cost, :total_cost, :units_sale_allowed, :is_mix_box,
                                      {product_prices_attributes: [:id, :price, :sales_commission, :profit_percent]},
                                      {product_boxes_attributes: [:_destroy, :id, :box_id, :stock_min, :stock_max]},
                                      {mix_box_details_attributes: [:_destroy, :id, :product_id, :quantity]},
                                      {box_ids: []})
    end
end
