module InventoriesHelper
  def build_UBD_action(inventory)
    fa_icon = 'fa-dropbox'
    #fa_icon_size = 'fa-2x'
    fa_icon_size = 'fa-lg'
    tooltip = t('simple_form.tooltips.uniform_box_disassembly')
    url = new_inventory_event_path(inventory_event: {event: InventoryEvent::EVENT_CONVERT, reason: InventoryEvent::REASON_UBD, product_id: inventory.product_id, expiration_date: inventory.expiration_date, quantity: 1, box_id: inventory.box_id})
    name = 'create'
    [{name: name, fa_icon: fa_icon, fa_icon_size: fa_icon_size, url: url, tooltip: tooltip}]
  end

  def build_UBA_action(inventory)
    fa_icon = 'fa-archive'
    fa_icon_size = 'fa-lg'
    tooltip = t('simple_form.tooltips.uniform_box_assembly')
    url = new_inventory_event_path(inventory_event: {event: InventoryEvent::EVENT_CONVERT, reason: InventoryEvent::REASON_UBA, product_id: inventory.product_id, expiration_date: inventory.expiration_date, quantity: 1})
    name = 'create'
    [{name: name, fa_icon: fa_icon, fa_icon_size: fa_icon_size, url: url, tooltip: tooltip}]
  end

  def build_adjust_action(inventory)
    fa_icon = 'fa-user'
    fa_icon_size = 'fa-lg'
    tooltip = t('simple_form.tooltips.adjust_quantity_available')
    url = new_inventory_event_path(inventory_event: {event: InventoryEvent::EVENT_ADJUST, reason: InventoryEvent::REASON_OCCASIONAL_ADJUST, product_id: inventory.product_id, expiration_date: inventory.expiration_date, box_id: inventory.box_id})
    name = 'create'
    [{name: name, fa_icon: fa_icon, fa_icon_size: fa_icon_size, url: url, tooltip: tooltip}]
  end

  def product_boxes
    boxes = @inventory_event.try(:product).try(:boxes)
    boxes = Box.all unless boxes
    boxes
    collection_with_actual(boxes, @inventory_event.box, :name, sortable = true)
  end

end
