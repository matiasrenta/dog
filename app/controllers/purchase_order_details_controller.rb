class PurchaseOrderDetailsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :purchase_order_detail_params

  # GET /purchase_order_details
  def index
    @purchase_order_details = indexize(PurchaseOrderDetail)
  end

  # GET /purchase_order_details/1
  def show
  end

  # GET /purchase_order_details/new
  def new
  end

  # GET /purchase_order_details/1/edit
  def edit
  end

  # POST /purchase_order_details
  def create

    if @purchase_order_detail.save
      redirect_to @purchase_order_detail, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@purchase_order_detail)
      render :new
    end
  end

  # PATCH/PUT /purchase_order_details/1
  def update
    if @purchase_order_detail.update(purchase_order_detail_params)
      redirect_to @purchase_order_detail, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@purchase_order_detail)
      render :edit
    end
  end

  # DELETE /purchase_order_details/1
  def destroy
    if @purchase_order_detail.destroy
      redirect_to purchase_order_details_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@purchase_order_detail)
      redirect_to purchase_order_details_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def purchase_order_detail_params
      params.require(:purchase_order_detail).permit(:box_id, :quantity, :product_unit_cost, :box_unit_cost, :purchase_order_id)
    end
end
