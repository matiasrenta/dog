class PurchaseOrdersController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :purchase_order_params

  # GET /purchase_orders
  def index
    @purchase_orders = indexize(PurchaseOrder)
  end

  # GET /purchase_orders/1
  def show
  end

  # GET /purchase_orders/new
  def new
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders
  def create

    if @purchase_order.save
      redirect_to @purchase_order, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@purchase_order)
      render :new
    end
  end

  # PATCH/PUT /purchase_orders/1
  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to @purchase_order, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@purchase_order)
      render :edit
    end
  end

  # DELETE /purchase_orders/1
  def destroy
    if @purchase_order.destroy
      redirect_to purchase_orders_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@purchase_order)
      redirect_to purchase_orders_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def purchase_order_params
      params.require(:purchase_order).permit(:supplier_id, :total_amount, :status, :notes)
    end
end
