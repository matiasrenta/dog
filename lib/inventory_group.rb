class InventoryGroup
  include ActiveModel::Model

  attr_accessor :product_id, :box_id#, :validation_date
  validates :product_id, :box_id, presence: true


  def initialize(attributes)
    super(attributes)
    after_initialize
  end

  def quantity_available
    @bunch_of_inventories.sum(:quantity_available)
  end

  def quantity_taken
    # solo las ordenes en estado "creada" se suman, las empaquetadas deberian estar en un rincón del galpon y no ser contadas a la hora de hacer inventario físico
    OrderDetail.created.by_product_id(self.product_id).by_box_id(self.box_id).sum(:quantity)
  end

  def fefo_remove(quantity_to_remove)
    @bunch_of_inventories.each do |inventory|
      if inventory.quantity_available >= quantity_to_remove
        inventory.quantity_available = inventory.quantity_available - quantity_to_remove
        inventory.save
        break
      else
        quantity_to_remove = quantity_to_remove - inventory.quantity_available
        inventory.quantity_available = 0
        inventory.save
      end
    end
  end

  private

  def after_initialize
    raise "product_id and box_id can't be blank" unless valid?
    @bunch_of_inventories = Inventory.by_product_id(self.product_id).by_box_id(self.box_id).order(expiration_date: :asc)
  end
end