class Promotion < ActiveRecord::Base
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


  belongs_to :box
  belongs_to :product
  has_many :prices, as: :priceable, dependent: :delete_all
  accepts_nested_attributes_for :prices

  PROMO_TYPE_WITH_STOCK = 'WITH_STOCK'
  PROMO_TYPE_WITHOUT_STOCK = 'WITHOUT_STOCK'
  PROMO_TYPES_FOR_SELECT = [ ['CON STOCK', PROMO_TYPE_WITH_STOCK], ['SIN STOCK', PROMO_TYPE_WITHOUT_STOCK] ]
  PROMO_TYPES_SYSTEM_ARRAY = PROMO_TYPES_FOR_SELECT.map{|p| p[1]}

  END_WITH_DATE = 'TO_DATE'
  END_WITH_STOCK = 'TO_FINISH_STOCK'
  END_WITH_ENDLESS = 'ENDLESS'
  END_WITH_FOR_SELECT = [ ['HASTA FECHA', END_WITH_DATE], ['HASTA TERMINAR STOCK', END_WITH_STOCK], ['SIN FIN', END_WITH_ENDLESS] ]
  END_WITH_SYSTEM_ARRAY = END_WITH_FOR_SELECT.map{|e| e[1]}

  validates :product_id, :box_id, :from_date, :end_with, :name, :promo_type, :product_total_cost, presence: true
  validates :product_id, :box_id, :product_total_cost, numericality: true


  def with_stock?
    self.promo_type == PROMO_TYPE_WITH_STOCK
  end

  def end_with_date?
    self.end_with == END_WITH_DATE
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
