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

  validates :product_id, :box_id, :quantity, :unit_price, :subtotal, presence: true
  validates :product_id, :box_id, :quantity, :unit_price, :subtotal, numericality: true
  validates :product_id, uniqueness: { scope: :order_id }
  validates :quantity_box, presence: true, unless: -> { box_id == 0 }
  validates :quantity_box, numericality: true, unless: -> { box_id == 0 }

  before_create do
    if self.box_id > 0
      self.box_id = Box.where(quantity: self.box_id).first.id
    end
  end

  after_save on: :create do
    product = Product.find(self.product_id)
    product.quantity_stock = product.quantity_stock - self.quantity
    product.save
  end

  after_destroy do
    product = Product.find(self.product_id)
    product.quantity_stock = product.quantity_stock + self.quantity
    product.save
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
