class Price < ActiveRecord::Base
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

  belongs_to :priceable, polymorphic: true
  belongs_to :customer_category

  validates :customer_category_id, :company_profit_percent, :seller_profit_percent, :seller_commission_over_price_percent, :price, presence: true
  validates :customer_category_id, :price, numericality: { greater_than: 0 }
  #validates [:priceable_id, :priceable_type], uniqueness: { scope: :customer_category_id }
  validates :customer_category_id, uniqueness: { scope: [:priceable_id, :priceable_type] }

  validates :company_profit_percent, numericality: true, if: -> {:priceable_type == 'Promotion'} # permitimos que sea negativo para los casos de rematar mercadería por debajo del costo
  validates :company_profit_percent, numericality: { greater_than: 0 }, if: -> {:priceable_type == 'Product'}
  validates :seller_profit_percent, :seller_commission_over_price_percent, numericality: { greater_than_or_equal_to: 0 }

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

end