class ProductPrice < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:update]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }

  belongs_to :product
  belongs_to :customer_category

  validates :product_id, :customer_category_id, :profit_percent, :sales_commission, :price, presence: true
  validates :product_id, :customer_category_id, :profit_percent, :sales_commission, :price, numericality: true
  validates :product_id, uniqueness: { scope: :customer_category_id }
  validates :profit_percent, numericality: { greater_than: 0 }
  validates :sales_commission, numericality: { greater_than_or_equal_to: 0 }

  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
