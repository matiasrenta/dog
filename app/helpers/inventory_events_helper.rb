module InventoryEventsHelper

  def products_collection
    if @inventory_event.event == InventoryEvent::EVENT_CONVERT && @inventory_event.reason == InventoryEvent::REASON_MBA
      Product.mix_boxes.code_and_name
    else
      # no puedo quitar las cajas surtidas porque si bien no se pueden hacer entradas, sí se pueden hacer salidas de cajas surtidas.
      # debería programar para que si se elije "ENTRADA" entonces este select no tiene surtidas, pero el dynamic_selec no es flexible para eso
      Product.code_and_name
    end
  end

end
