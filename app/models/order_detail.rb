class OrderDetail < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }

  belongs_to :order
  belongs_to :product
  belongs_to :box

  validates :product_id, :box_id, :quantity_units, :unit_price, :subtotal, presence: true
  validates :product_id, :box_id, :quantity_units, :unit_price, :subtotal, numericality: true
  validates :product_id, uniqueness: { scope: :order_id }
  validates :quantity, presence: true #, unless: -> { box_id == 0 }
  validates :quantity, numericality: true #, unless: -> { box_id == 0 }

  scope :created, -> { joins(:order).where( "orders.status = 'CREATED'") }
  scope :by_product_id, -> (product_id) { where(product_id: product_id)}
  scope :by_box_id, -> (box_id) { where(box_id: box_id)}

  #before_create do
  #  self.box_id = Box.where(quantity: self.box_id).first.id
  #end

  before_save  on: :create do
    self.box_id = Box.where(quantity: self.box_id).first.id # este es un patch, porque en el select del html le pongo la cantidad en el id. porque no pude ponerlo en un hidden o algo elegante
    stock_available = Inventory.stock_available(self.product_id, self.box_id)
    if stock_available < self.quantity
      errors.add(:quantity, "No hay stock suficiente. Stock actual: #{stock_available}")
    else
      Inventory.update_stock(self, {event: InventoryEvent::EVENT_REMOVE, reason: InventoryEvent::REASON_SALE})
    end
  end

  after_destroy do
    # agrego al stock lo que se quitó cuando se creó esta entidad
    Inventory.update_stock(self, {event: InventoryEvent::EVENT_ADD, reason: InventoryEvent::REASON_ORDER_DESTROY})
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
