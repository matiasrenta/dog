class PromotionsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :promotion_params

  # GET /promotions
  def index
    @promotions = indexize(Promotion)
  end

  # GET /promotions/1
  def show
  end

  # GET /promotions/new
  def new
    CustomerCategory.all.each do |cc|
      @promotion.prices.build(customer_category_id: cc.id, company_profit_percent: cc.company_profit_percent, seller_profit_percent: cc.seller_profit_percent, seller_commission_over_price_percent: cc.seller_commission_over_price_percent, price: nil)
    end
  end

  # GET /promotions/1/edit
  def edit
  end

  # POST /promotions
  def create
    if @promotion.save
      redirect_to @promotion, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@promotion)
      render :new
    end
  end

  # PATCH/PUT /promotions/1
  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@promotion)
      render :edit
    end
  end

  # DELETE /promotions/1
  def destroy
    if @promotion.destroy
      redirect_to promotions_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@promotion)
      redirect_to promotions_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def promotion_params
      params.require(:promotion).permit(:product_id, :box_id, :expiration_date, :quantity_start, :quantity_available, :from_date, :end_with, :to_date, :name, :notes, :promo_type)
    end
end
