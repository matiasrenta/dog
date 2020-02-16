class CustomerContactsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :customer_contact_params

  # GET /customer_contacts
  def index
  end

  # GET /customer_contacts/1
  def show
  end

  # GET /customer_contacts/new
  def new
    @customer = Customer.find(params[:customer_id])
  end

  # GET /customer_contacts/1/edit
  def edit
    @customer = @customer_contact.customer
  end

  # POST /customer_contacts
  def create
    @customer = Customer.find(params[:customer_id])
    @customer_contact = @customer.customer_contacts.build(customer_contact_params)
    if @customer_contact.save
      redirect_to @customer, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@customer_contact)
      render :new
    end
  end

  # PATCH/PUT /customer_contacts/1
  def update
    if @customer_contact.update(customer_contact_params)
      redirect_to @customer_contact.customer, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@customer_contact)
      render :edit
    end
  end

  # DELETE /customer_contacts/1
  def destroy
    if @customer_contact.destroy
      redirect_to @customer_contact.customer, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@customer_contact)
      redirect_to @customer_contact.customer
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def customer_contact_params
      params.require(:customer_contact).permit(:name, :phones, :email, :notes, :customer_id)
    end
end
