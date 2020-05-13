require 'inventory_group'

class Inventory < ActiveRecord::Base
  belongs_to :box
  belongs_to :product

  validates :product_id, :box_id, :quantity_available, :quantity_available_in_units, presence: true
  validates :product_id, :box_id, :quantity_available, :quantity_available_in_units, numericality: true

  scope :by_product_id, -> (product_id){where(product_id: product_id)}
  scope :by_box_id, -> (box_id){where(box_id: box_id)}
  scope :by_expiration_date, -> (expiration_date){where(expiration_date: expiration_date)}
  scope :not_this_box_id, -> (box_id) {where('box_id <> ?', box_id)}
  scope :order_by_exp_date, -> {order(:expiration_date)}

  before_save do
    self.quantity_available_in_units = self.quantity_available * self.box.quantity
  end

  def self.get_or_initialize_inventory(product_id, box_id, expiration_date)
    inventory = Inventory.where(product_id: product_id, box_id: box_id, expiration_date: expiration_date).first_or_initialize
    if inventory.new_record?
      inventory.quantity_available = 0
      inventory.quantity_available_in_units = 0
    end
    inventory
  end

  def self.update_stock(entity, data = {event: nil, reason: nil, expiration_date: nil})
    if data[:event] == InventoryEvent::EVENT_ADD && InventoryEvent::ADD_REASONS.include?(data[:reason])
      add(entity, data)
    elsif data[:event] == InventoryEvent::EVENT_REMOVE && InventoryEvent::REMOVE_REASONS.include?(data[:reason])
      remove(entity, data)
    elsif data[:event] == InventoryEvent::EVENT_ADJUST && InventoryEvent::ADJUST_REASONS.include?(data[:reason])
      adjust(entity, data)
    elsif data[:event] == InventoryEvent::EVENT_CONVERT && InventoryEvent::CONVERT_REASONS.include?(data[:reason])
      convert(entity, data)
    else
      raise(I18n.t('activerecord.errors.models.inventory_event.attributes.event.reason_not_matching'))
    end

    InventoryEvent.handle_event_creation(event: data[:event],
                                         reason: data[:reason],
                                         entity_id: entity.id,
                                         entity_type: entity.class.name,
                                         entity_serialize: entity.serialize,
                                         quantity: entity.quantity,
                                         box_id: entity.box_id,
                                         product_id: entity.product_id,
                                         expiration_date: nil)

  end


  def quantity_taken
    OrderDetail.created.by_product_id(self.product_id).by_box_id(self.box_id).by_expiration_date(self.expiration_date).sum(:quantity)
  end


  def quantity_warehouse
    self.quantity_taken + self.quantity_available
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  # ADD
  def self.add(entity, data = {})
    inventory = get_or_initialize_inventory(entity.product_id, entity.box_id, data[:expiration_date])
    inventory.quantity_available = inventory.quantity_available + entity.quantity
    inventory.save
    # aqui podría insertar el evento
  end

  # REMOVE
  def self.remove(entity, data = {})
    if data[:expiration_date].present?
      inventory = get_or_initialize_inventory(entity.product_id, entity.box_id, data[:expiration_date])
      quantity_to_remove = entity.quantity
      if inventory.quantity_available >= quantity_to_remove
        inventory.quantity_available = inventory.quantity_available - quantity_to_remove
        inventory.save
      else
        raise("no hay stock suficiente. Stock actual: #{inventory.quantity_available} #{inventory.try(:box).try(:name)}")
      end
    else
      # si no se pasa un expiration_date entonces puede que sean muchos inventories (InventoryGroup)
      inventory_group = InventoryGroup.new(product_id: entity.product_id, box_id: entity.box_id)
      quantity_to_remove = entity.quantity
      if inventory_group.quantity_available >= quantity_to_remove
        inventory_group.fefo_remove(quantity_to_remove)
      else
        raise("no hay stock suficiente. Stock actual: #{inventory_group.quantity_available} #{entity.box.name}")
      end
    end
  end

  # ADJUST
  def self.adjust(entity, data)
    inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date])
    # si hay diferenca suma o resta segun corresponda, si no hay diferenia suma cero
    inventory.quantity_available = inventory.quantity_available + (data[:phisical_quantity_warehouse_count] - inventory.quantity_warehouse)
  end

  # CONVERT
  def self.convert(entity, data)
    if entity.box.is_the_units_box? || entity.reason == InventoryEvent::REASON_UBA
      if entity.product.is_mix_box
        #todo: implementation pending
      else
        # todo: aun no esta del todo implementado, falta definir cuantas cajas queres armar, o si queres armar todas las cajas que se puedan con las unidades existentes
        convert_units_to_box(entity, data)
      end
    else
      convert_box_to_units(entity, data)
      #todo: implementation pending for box to box convertion
    end
  end

  def self.convert_box_to_units(entity, data)
    inventory = get_or_initialize_inventory(entity.product_id, entity.box_id, entity.expiration_date)
    raise 'No hay stock para convertir' if inventory.new_record?
    units_inventory = get_or_initialize_inventory(entity.product_id, Box.units_box.id, entity.expiration_date)
    if inventory.quantity_available >= entity.quantity
      inventory.quantity_available = inventory.quantity_available - entity.quantity
      units_inventory.quantity_available = units_inventory.quantity_available + (Box.find(entity.box_id).quantity * entity.quantity)
      inventory.save
      units_inventory.save
    else
      raise "No hay stock para convertir. Stock actual: #{inventory.quantity_available} #{entity.box.name}"
    end
  end

  def self.convert_units_to_box(entity, data)
    box_to_create = Box.find(entity.box_id)
    inventory = get_or_initialize_inventory(entity.product_id, Box.units_box.id, entity.expiration_date)
    raise 'No hay stock para convertir' if inventory.new_record?

    box_inventory = get_or_initialize_inventory(entity.product_id, box_to_create.id, entity.expiration_date)
    how_many_boxes_to_create = entity.quantity
    quantity_units_to_convert = how_many_boxes_to_create * box_to_create.quantity

    if inventory.quantity_available >= quantity_units_to_convert
      inventory.quantity_available = inventory.quantity_available - quantity_units_to_convert
      box_inventory.quantity_available = box_inventory.quantity_available + how_many_boxes_to_create
      inventory.save
      box_inventory.save
    else
      raise "No hay suficiente stock para convertir. Stock actual: #{inventory.quantity_available} #{Box.units_box.name}"
    end
  end


end
