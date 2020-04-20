class Product < ActiveRecord::Base
  has_many :boxes, dependent: :restrict_with_error
  has_many :order_details, dependent: :restrict_with_error
	include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }

  has_many :product_prices, dependent: :delete_all
  accepts_nested_attributes_for :product_prices

  validates :code, :name, :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :sale_price, :profit_percent, :saleman_fee_percent, presence: true
  validates :code, :name, uniqueness: true
  validates :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :sale_price, :profit_percent, :saleman_fee_percent, numericality: true




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
