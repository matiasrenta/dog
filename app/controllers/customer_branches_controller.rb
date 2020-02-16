class CustomerBranchesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :customer_branch_params

  # GET /customer_branches
  def index
  end

  # GET /customer_branches/1
  def show
  end

  # GET /customer_branches/new
  def new
    @customer = Customer.find(params[:customer_id])
  end

  # GET /customer_branches/1/edit
  def edit
    @customer = @customer_branch.customer
  end

  # POST /customer_branches
  def create
    @customer = Customer.find(params[:customer_id])
    @customer_branch = @customer.customer_branches.build(customer_branch_params)
    if @customer_branch.save
      redirect_to @customer, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@customer_branch)
      render :new
    end
  end

  # PATCH/PUT /customer_branches/1
  def update
    if @customer_branch.update(customer_branch_params)
      redirect_to @customer_branch.customer, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@customer_branch)
      render :edit
    end
  end

  # DELETE /customer_branches/1
  def destroy
    if @customer_branch.destroy && @customer_branch.customer.valid?
      redirect_to @customer_branch.customer, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@customer_branch)
      redirect_to @customer_branch.customer
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def customer_branch_params
      params.require(:customer_branch).permit(:customer_id, :name, :address, :notes)
    end
end
