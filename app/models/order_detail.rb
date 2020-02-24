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


  belongs_to :product
  belongs_to :order

  before_validation do
    if self.quantity.to_i > 0 && self.unit_price.to_i > 0
      self.subtotal = (self.quantity.to_f * self.unit_price.to_f).round(4)
    end
  end

  validates :product_id, :quantity, :unit_price, :subtotal, presence: true
  validates :product_id, :quantity, :unit_price, :subtotal, numericality: true
  validates :product_id, uniqueness: { scope: :order_id }

  after_save do
    #self.order.total_amount = self.order.order_details.sum(:subtotal)
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
