class ProductsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_params

  # GET /products
  def index
    @products = do_index(Product, params)
  end

  # GET /products/1
  def show
    @prices = @product.prices
    @product_boxes = indexize(ProductBox, collection: @product.product_boxes, query_param: :q_box)
    @mix_box_details = indexize(MixBoxDetail, collection: @product.mix_box_details, query_param: :q_mix_box)
  end

  # GET /products/new
  def new
    CustomerCategory.all.each do |cc|
      @product.prices.build(customer_category_id: cc.id,
                            company_profit_percent: cc.company_profit_percent,
                            seller_profit_percent: cc.seller_profit_percent,
                            total_profit_percent: cc.total_profit_percent,
                            seller_commission_over_price_percent: cc.seller_commission_over_price_percent, price: nil)
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    if @product.save
      #flash[:info] = t('simple_form.flash.info.check_prices')
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
                                      {prices_attributes: [:id, :customer_category_id, :company_profit_percent, :seller_profit_percent, :total_profit_percent, :seller_commission_over_price_percent, :price]},
                                      {product_boxes_attributes: [:_destroy, :id, :box_id, :stock_min, :stock_max]},
                                      {mix_box_details_attributes: [:_destroy, :id, :product_id, :quantity]},
                                      {box_ids: []})
    end
end
