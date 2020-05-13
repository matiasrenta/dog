class InventoriesController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :inventory_params

  # GET /inventories
  def index
    @inventories = indexize(Inventory)
  end

  # GET /inventories/1
  def show
  end

  # GET /inventories/new
  def new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories
  def create
    if @inventory.save
      redirect_to @inventory, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@inventory)
      render :new
    end
  end

  # PATCH/PUT /inventories/1
  def update
    if @inventory.update(inventory_params)
      redirect_to @inventory, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@inventory)
      render :edit
    end
  end

  # DELETE /inventories/1
  def destroy
    if @inventory.destroy
      redirect_to inventories_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@inventory)
      redirect_to inventories_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def inventory_params
      params.require(:inventory).permit(:product_id, :lot, :expiration_date, :box_id, :quantity_available, :quantity_available_in_units)
    end
end
