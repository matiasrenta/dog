class InventoryEventsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :inventory_event_params

  # GET /inventory_events
  def index
    @inventory_events = indexize(InventoryEvent)
  end

  # GET /inventory_events/1
  def show
  end

  # GET /inventory_events/new
  def new
  end

  # GET /inventory_events/1/edit
  def edit
  end

  # POST /inventory_events
  def create
    if @inventory_event.valid?
      #ret = Inventory.add(@inventory_event, {expiration_date: @inventory_event.expiration_date.present? ? @inventory_event.expiration_date : nil})
      ret = Inventory.update_stock(@inventory_event, {event: @inventory_event.event, reason: @inventory_event.reason, expiration_date: @inventory_event.expiration_date} )
      redirect_to inventories_path, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@inventory_event)
      render :new
    end

    #if @inventory_event.save
    #  redirect_to @inventory_event, notice: t("simple_form.flash.successfully_created")
    #else
    #  puts "@@@@@@@@@@@@@@@@@@@@@@ #{@inventory_event.errors.full_messages}"
    #  generate_flash_msg_no_keep(@inventory_event)
    #  render :new
    #end
  end

  # PATCH/PUT /inventory_events/1
  def update
    if @inventory_event.update(inventory_event_params)
      redirect_to @inventory_event, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@inventory_event)
      render :edit
    end
  end

  # DELETE /inventory_events/1
  def destroy
    if @inventory_event.destroy
      redirect_to inventory_events_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@inventory_event)
      redirect_to inventory_events_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def inventory_event_params
      params.require(:inventory_event).permit(:product_id, :expiration_date, :event, :reason, :notes, :entity_id, :entity_type, :entity_serialized, :quantity, :box_id)
    end
end
