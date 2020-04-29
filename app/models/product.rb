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


  has_many :order_details #NO VEO LA UTILIDAD DE ESTE LADO DE LA RELACION. CREO QUE NUNCA LA USARÉ

  # product_mix_boxes es la relacion tipo Factura - Detalle. En este caso el producto es la Mix Box
  has_many :mix_box_details, foreign_key: :mix_box_id, dependent: :destroy

  # esta relación quiere decir que los "detalles" de las mix_boxes tienen como atributo un producto. asi como los order_details tienen un atributo product_id
  # ASÍ COMO NO HACE FALTA "has_many :order_details" TAMPOCO HACE FALTA ESTE EXTREMO DE LA RELACION. PARA NO CONFUNDIRME LA COMENTO
  #has_many :products, class_name: 'MixBoxDetail', foreign_key: :product_id # si este producto es una mix_box entonces tiene muchos (has_many) items




  has_many :product_prices, dependent: :delete_all
  has_many :product_boxes, dependent: :delete_all
  accepts_nested_attributes_for :product_prices, update_only: true
  accepts_nested_attributes_for :product_boxes, allow_destroy: true
  accepts_nested_attributes_for :mix_box_details, allow_destroy: true, allow_destroy: true

  validates :code, :name, :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :saleman_fee_percent, presence: true
  validates :code, :name, uniqueness: true
  validates :quantity_stock, :quantity_min, :quantity_max, :product_cost, :cargo_cost, :total_cost, :saleman_fee_percent, numericality: true
  validates :units_sale_allowed, inclusion: {in: [true, false]}

  before_save do
    self.is_mix_box = self.mix_box_details.select{|pmb| !pmb.marked_for_destruction?}.size > 1
    true # para que no impida el save cuando da false
  end

  after_create do
    ProductPrice.transaction do
      CustomerCategory.all.each do |customer_category|
        product_price = ProductPrice.new(product_id: self.id, customer_category_id: customer_category.id, price: calculate_product_price(customer_category))
        product_price.save
      end
    end
  end

  after_update do
    if self.total_cost_changed?
      ProductPrice.transaction do
        CustomerCategory.all.each do |customer_category|
          product_price = ProductPrice.where(product_id: self.id, customer_category_id: customer_category.id).first
          product_price.price = calculate_product_price(customer_category)
          product_price.save
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
