class CustomerCategory < ActiveRecord::Base
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

  has_many :customers, dependent: :restrict_with_error
  has_many :prices, dependent: :delete_all

  validates :name, :company_profit_percent, :seller_profit_percent, presence: true
  validates :company_profit_percent, :seller_profit_percent, numericality: true
  validates :name, uniqueness: true

  after_create do
    Product.all.each do |product|
      price = Price.new(priceable_id: product.id, priceable_type: product, customer_category_id: self.id, price: product.calculate_price(self))
      price.save
    end
  end

  #todo: no se actualizan los precios si se hace update de un customer_category. esto rompería los precios "lindos" que se han hecho a mano
  # la idea es que esto sea un template solo para la creación
#  after_update do
#    if self.profit_percent_changed? || self.sales_commission_changed?
#     # ProductPrice.transaction do
#        Product.all.each do |product|
#          product_price = ProductPrice.where(product_id: product.id, customer_category_id: self.id).first
#          product_price.price = calculate_product_price(product)
#          product_price.save #
#        end
#      #end
#    end
#  end



  def except_attr_in_public_activity
    [:id, :updated_at]
  end

end
