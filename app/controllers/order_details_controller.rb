class OrderDetailsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :order_detail_params

  # GET /order_details
  def index
    @order_details = indexize(OrderDetail)
  end

  # GET /order_details/1
  def show
  end

  # GET /order_details/new
  def new
  end

  # GET /order_details/1/edit
  def edit
  end

  # POST /order_details
  def create

    if @order_detail.save
      redirect_to @order_detail, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@order_detail)
      render :new
    end
  end

  # PATCH/PUT /order_details/1
  def update
    if @order_detail.update(order_detail_params)
      redirect_to @order_detail, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@order_detail)
      render :edit
    end
  end

  # DELETE /order_details/1
  def destroy
    if @order_detail.destroy
      redirect_to @order_detail.order, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@order_detail)
      redirect_to @order_detail.order
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def order_detail_params
      params.require(:order_detail).permit(:order_id, :product_id, :quantity, :unit_price)
    end
end
