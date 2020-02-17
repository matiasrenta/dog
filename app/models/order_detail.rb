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
    puts("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DEBUG 0:  #{self.quantity}")
    if self.quantity.to_i > 0 && self.unit_price.to_i > 0
      puts("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DEBUG 5:  #{self.quantity}, self.unit_price.to_i")
      self.subtotal = (self.quantity.to_f * self.unit_price.to_f).round(4)
      puts("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DEBUG 6:  #{self.subtotal.to_i}")
    end
  end

  validates :product_id, :quantity, :unit_price, :subtotal, presence: true
  validates :product_id, :quantity, :unit_price, :subtotal, numericality: true

  after_save do
    #self.order.total_amount = self.order.order_details.sum(:subtotal)
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
