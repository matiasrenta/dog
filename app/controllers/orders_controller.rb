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
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@order)
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

  def ajax_get_product_info
    unless params[:the_id].blank? || params[:order].blank? || params[:order][:customer_id].blank?
      @product = Product.find params[:the_id]
      customer = Customer.find params[:order][:customer_id]
      @product_price = ProductPrice.where(product_id: @product.id, customer_category_id: customer.customer_category_id).first

      if params[:the_this_html_id].include?("order_order_details_attributes")
        #debo de obtener el id del dropdown que tiene los horarios, se diferencian por el nro, son del tipo:
        #para el new: patient_therapies_attributes_1400520810110_therapist_schedule_ids
        #para el edit: patient_therapies_attributes_1_therapist_schedule_ids

        # order_order_details_attributes_1587229395946_product_id
        params[:the_this_html_id].split('_').each do |the_number|
          tn = the_number.to_i
          entity = "order_details"
          @unit_price_html_input_id = "#order_#{entity}_attributes_#{tn}_unit_price" if tn != 0 || the_number == "0" # este if tiene sentido aunque parezca que no. tn puede ser cero porque no hay numeros en the_number al hacer the_number.to_i
          @stock_at_create_html_input_id = "#order_#{entity}_attributes_#{tn}_stock_at_create" if tn != 0 || the_number == "0" # este if tiene sentido aunque parezca que no. tn puede ser cero porque no hay numeros en the_number al hacer the_number.to_i
        end
      end
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:customer_id, :customer_branch_id, :user_id, :total_amount, :status, :comisionado, :delivery_date,  {order_details_attributes: [:_destroy, :id, :product_id, :quantity, :unit_price, :stock_at_create]})
    end
end
