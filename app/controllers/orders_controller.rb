class OrdersController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :order_params

  # GET /orders
  def index
    @orders = indexize(Order)
  end

  # GET /orders/1
  def show
    @order_details = indexize(OrderDetail, collection: @order.order_details)
  end

  # GET /orders/new
  def new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create

    if @order.save
      redirect_to @order, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@order)
      puts "DEBUG 1: #{@order.errors.messages}"
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@order)
      puts "DEBUG 2: #{@order.errors.messages}"
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    if @order.destroy
      redirect_to orders_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@order)
      redirect_to orders_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:customer_id, :customer_branch_id, :user_id, :total_amount, :status, :comisionado, :delivery_date,  {order_details_attributes: [:_destroy, :id, :product_id, :quantity, :unit_price]})
    end
end
