class Product < ActiveRecord::Base

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

  has_many :product_mix_boxes, class_name: 'ProductMixBox', foreign_key: :mix_box_id, dependent: :destroy  # existen muchos productos que son mix_box
  has_many :products, class_name: 'ProductMixBox', foreign_key: 'product_id' # si este producto es una mix_box entonces tiene muchos (has_many) items

  has_many :product_prices, dependent: :delete_all
  has_many :product_boxes, dependent: :delete_all
  accepts_nested_attributes_for :product_prices, update_only: true
  accepts_nested_attributes_for :product_boxes, allow_destroy: true
  accepts_nested_attributes_for :product_mix_boxes, allow_destroy: true, allow_destroy: true

  validates :code, :name, :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :saleman_fee_percent, presence: true
  validates :code, :name, uniqueness: true
  validates :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :saleman_fee_percent, numericality: true
  validates :units_sale_allowed, inclusion: {in: [true, false]}

  after_create do
    ProductPrice.transaction do
      CustomerCategory.all.each do |customer_category|
        product_price = ProductPrice.new(product_id: self.id, customer_category_id: customer_category.id, price: calculate_product_price(customer_category))
        product_price.save!
      end
    end
  end

  after_update do
    if self.total_cost_changed?
      ProductPrice.transaction do
        CustomerCategory.all.each do |customer_category|
          product_price = ProductPrice.where(product_id: self.id, customer_category_id: customer_category.id).first
          product_price.price = calculate_product_price(customer_category)
          product_price.save!
        end
      end
    end
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  def calculate_product_price(customer_category)
    self.total_cost + (self.total_cost * (customer_category.profit_percent.to_f / 100))
  end

end
