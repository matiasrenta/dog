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
  scope :with_quantity_available_cero, -> {where(quantity_available: 0)}

  before_save do
    self.quantity_available_in_units = self.quantity_available * self.box.quantity

    # esto borra todos los inventories que hayan quedado con quantity_warehouse en cero. incluye al actual registro
    # es una tarea de mantenimiento, prodría estar en un cron pero mejor es aquí
    Inventory.with_quantity_available_cero.map(){|i| i.destroy if i.quantity_warehouse == 0}
  end

  def self.stock_available(product_id, box_id, expiration_date = nil)
    if expiration_date.blank?
      InvGrouped.stock_available(product_id, box_id)
    else
      by_product_id(product_id).by_box_id(box_id).by_expiration_date(expiration_date).sum(:quantity_available)
    end

  end

  def self.get_or_initialize_inventory(product_id, box_id, expiration_date)
    inventory = Inventory.where(product_id: product_id, box_id: box_id, expiration_date: expiration_date).first_or_initialize
    if inventory.new_record?
      inventory.quantity_available = 0
      inventory.quantity_available_in_units = 0
    end
    inventory
  end

#  def self.get_inventory(product_id, box_id, expiration_date)
#    inventory = get_or_initialize_inventory(product_id, box_id, expiration_date)
#    if inventory.new_record?
#      return nil
#    else
#      inventory
#    end
#  end

  # data tiene que tener los siguientes campos {product_id: , box_id:, expiration_date: nil , event:, reason: }
  def self.update_stock(data)
    if data[:event] == InventoryEvent::EVENT_ADD && InventoryEvent::ADD_REASONS.include?(data[:reason])
      add(data)
    elsif data[:event] == InventoryEvent::EVENT_REMOVE && InventoryEvent::REMOVE_REASONS.include?(data[:reason])
      remove(data)
    elsif data[:event] == InventoryEvent::EVENT_ADJUST && InventoryEvent::ADJUST_REASONS.include?(data[:reason])
      adjust(data)
    elsif data[:event] == InventoryEvent::EVENT_CONVERT && InventoryEvent::CONVERT_REASONS.include?(data[:reason])
      convert(data)
    else
      raise(I18n.t('activerecord.errors.models.inventory_event.attributes.event.reason_not_matching'))
    end
  end


  def quantity_taken
    OrderDetail.created.by_product_id(self.product_id).by_box_id(self.box_id).sum(:quantity)
  end

  def quantity_promoted
    Promotion.by_product(self.product_id).by_box(self.box_id).sum(:quantity_available)
  end

  def quantity_warehouse
    self.quantity_available + self.quantity_taken + self.quantity_promoted
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  # ADD
  def self.add(data)
    inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date])
    inventory.quantity_available = inventory.quantity_available + data[:quantity]
    inventory.save
  end

  # REMOVE
  def self.remove(data)
    if data[:expiration_date].present?
      inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date])
      quantity_to_remove = data[:quantity]
      if inventory.quantity_available >= quantity_to_remove
        inventory.quantity_available = inventory.quantity_available - quantity_to_remove
        inventory.save
      else
        raise("no hay stock suficiente. Stock actual: #{inventory.quantity_available} #{inventory.try(:box).try(:name)}")
      end
    else
      # si no se pasa un expiration_date entonces puede que sean muchos inventories (InventoryGroup)
      inventory_group = InventoryGroup.new(product_id: data[:product_id], box_id: data[:box_id])
      quantity_to_remove = data[:quantity]
      if inventory_group.quantity_available >= quantity_to_remove
        inventory_group.fefo_remove(quantity_to_remove)
      else
        raise("no hay stock suficiente. Stock actual: #{inventory_group.quantity_available} #{Box.find(data[:box_id]).name}")
      end
    end
  end

  # ADJUST
  def self.adjust(data)
    inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date])
    # si hay diferenca suma o resta segun corresponda, si no hay diferenia suma cero
    inventory.quantity_available = inventory.quantity_available + (data[:phisical_quantity_warehouse_count] - inventory.quantity_warehouse)
  end

  # CONVERT
  def self.convert(data)
    data[:product] = Product.find data[:product_id]
    data[:box] = Box.find data[:box_id]

    if data[:box].is_the_units_box? || data[:reason] == InventoryEvent::REASON_UBA
      if data[:product].is_mix_box
        convert_units_to_mix_box(data)
      else
        # todo: aun no esta del todo implementado, falta si queres armar todas las cajas que se puedan con las unidades existentes
        convert_units_to_box(data)
      end
    else
      convert_box_to_units(data)
      #todo: implementation pending for box to box convertion
    end
  end

  def self.convert_box_to_units(data)
    inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date])
    raise 'No hay stock para convertir' if inventory.new_record?
    units_inventory = get_or_initialize_inventory(data[:product_id], Box.units_box.id, data[:expiration_date])
    if inventory.quantity_available >= data[:quantity]
      inventory.quantity_available = inventory.quantity_available - data[:quantity]
      units_inventory.quantity_available = units_inventory.quantity_available + (Box.find(data[:box_id]).quantity * data[:quantity])
      inventory.save
      units_inventory.save
    else
      raise "No hay stock para convertir. Stock actual: #{inventory.quantity_available} #{data[:box].name}"
    end
  end

  def self.convert_units_to_box(data)
    box_to_create = Box.find(data[:box_id])
    inventory = get_or_initialize_inventory(data[:product_id], Box.units_box.id, data[:expiration_date])
    raise 'No hay stock para convertir' if inventory.new_record?

    box_inventory = get_or_initialize_inventory(data[:product_id], box_to_create.id, data[:expiration_date])
    how_many_boxes_to_create = data[:quantity]
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

  def self.convert_units_to_mix_box(data)
    data[:product].mix_box_details.each do |mix_box_detail|
      inventory_group = InventoryGroup.new(product_id: mix_box_detail.product_id, box_id: Box.units_box.id)
      if inventory_group.quantity_available >= mix_box_detail.quantity
        inventory_group.fefo_remove(mix_box_detail.quantity)
      else
        raise "No hay suficiente stock para convertir. Stock actual de #{mix_box_detail.product.name}: #{inventory_group.quantity_available} #{Box.units_box.name}"
      end
    end
    inventory = get_or_initialize_inventory(data[:product_id], data[:box_id], data[:expiration_date]) # la fecha de vto de una caja surtida es la del producto que venza primero
    inventory.quantity_available = inventory.quantity_available + data[:quantity]
    inventory.save
  end


end
