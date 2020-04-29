class ProductBrandsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :product_brand_params

  # GET /product_brands
  def index
    @product_brands = indexize(ProductBrand)
  end

  # GET /product_brands/1
  def show
  end

  # GET /product_brands/new
  def new
  end

  # GET /product_brands/1/edit
  def edit
  end

  # POST /product_brands
  def create
    if @product_brand.save
      redirect_to @product_brand, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@product_brand)
      render :new
    end
  end

  # PATCH/PUT /product_brands/1
  def update
    if @product_brand.update(product_brand_params)
      redirect_to @product_brand, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@product_brand)
      render :edit
    end
  end

  # DELETE /product_brands/1
  def destroy
    if @product_brand.destroy
      redirect_to product_brands_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@product_brand)
      redirect_to product_brands_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def product_brand_params
      params.require(:product_brand).permit(:name)
    end
end
