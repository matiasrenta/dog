module InventoryEventsHelper

  def products_collection
    if @inventory_event.event == InventoryEvent::EVENT_CONVERT && @inventory_event.reason == InventoryEvent::REASON_MBA
      Product.mix_boxes.code_and_name
    else
      Product.code_and_name
    end
  end

end
