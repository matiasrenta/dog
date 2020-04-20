class ProductPricesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_price_params

  # GET /product_prices
  def index
    @product_prices = indexize(ProductPrice)
  end

  # GET /product_prices/1
  def show
  end

  # GET /product_prices/new
  def new
  end

  # GET /product_prices/1/edit
  def edit
  end

  # POST /product_prices
  def create
    if @product_price.save
      redirect_to @product_price, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@product_price)
      render :new
    end
  end

  # PATCH/PUT /product_prices/1
  def update
    if @product_price.update(product_price_params)
      redirect_to @product_price, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@product_price)
      render :edit
    end
  end

  # DELETE /product_prices/1
  def destroy
    if @product_price.destroy
      redirect_to product_prices_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@product_price)
      redirect_to product_prices_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def product_price_params
      params.require(:product_price).permit(:product_id, :customer_category_id, :price)
    end
end
