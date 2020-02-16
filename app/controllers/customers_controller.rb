class CustomersController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :customer_params

  # GET /customers
  def index
    @customers = do_index(Customer, params)
  end

  # GET /customers/1
  def show
  end

  # GET /customers/new
  def new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  def create
    if @customer.save
      redirect_to @customer, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@customer)
      render :new
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@customer)
      render :edit
    end
  end

  # DELETE /customers/1
  def destroy
    if @customer.destroy
      redirect_to customers_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@customer)
      redirect_to customers_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:code, :name, :notes)
    end
end
