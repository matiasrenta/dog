class CustomerCategoriesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :customer_category_params

  # GET /customer_categories
  def index
    @customer_categories = indexize(CustomerCategory)
  end

  # GET /customer_categories/1
  def show
  end

  # GET /customer_categories/new
  def new
  end

  # GET /customer_categories/1/edit
  def edit
  end

  # POST /customer_categories
  def create
    if @customer_category.save
      redirect_to @customer_category, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@customer_category)
      render :new
    end
  end

  # PATCH/PUT /customer_categories/1
  def update
    if @customer_category.update(customer_category_params)
      redirect_to @customer_category, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@customer_category)
      render :edit
    end
  end

  # DELETE /customer_categories/1
  def destroy
    if @customer_category.destroy
      redirect_to customer_categories_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@customer_category)
      redirect_to customer_categories_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def customer_category_params
      params.require(:customer_category).permit(:name, :profit_percent, :sales_commission)
    end
end
