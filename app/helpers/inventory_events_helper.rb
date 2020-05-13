module InventoryEventsHelper

  def products_collection
    if @inventory_event.event == InventoryEvent::EVENT_CONVERT && @inventory_event.reason == InventoryEvent::REASON_MBA
      Product.mix_boxes.map{ |p| ["#{p.code} #{p.name}", p.id] }
    else
      Product.all.map{ |p| ["#{p.code} #{p.name}", p.id] }
    end
  end

end
