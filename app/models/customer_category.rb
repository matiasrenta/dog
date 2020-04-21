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
  has_many :product_prices, dependent: :delete_all

  validates :name, :profit_percent, presence: true
  validates :name, uniqueness: true
  validates :profit_percent, numericality: true

  after_create do
    ProductPrice.transaction do
      Product.all.each do |product|
        product_price = ProductPrice.new(product_id: product.id, customer_category_id: self.id, price: calculate_product_price(product))
        product_price.save!
      end
    end
  end

  after_update do
    if self.profit_percent_changed?
      ProductPrice.transaction do
        Product.all.each do |product|
          product_price = ProductPrice.where(product_id: product.id, customer_category_id: self.id).first
          product_price.price = calculate_product_price(product)
          product_price.save!
        end
      end
    end
  end



  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  def calculate_product_price(product)
    product.total_cost + (product.total_cost * (self.profit_percent.to_f / 100))
  end
end
