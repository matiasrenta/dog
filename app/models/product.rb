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


  belongs_to :product_brand
  #has_and_belongs_to_many :boxes, join_table: 'boxes_products'
  has_many :product_boxes, dependent: :destroy
  has_many :boxes, through: :product_boxes
  has_many :order_details #NO VEO LA UTILIDAD DE ESTE LADO DE LA RELACION. CREO QUE NUNCA LA USARÉ
  has_many :inventories, dependent: :restrict_with_error

  # mix_box_details es la relacion tipo Factura - Detalle. En este caso el producto es la Mix Box
  has_many :mix_box_details, foreign_key: :mix_box_id, dependent: :destroy

  # esta relación quiere decir que los "detalles" de las mix_boxes tienen como atributo un producto. asi como los order_details tienen un atributo product_id
  # ASÍ COMO NO HACE FALTA "has_many :order_details" TAMPOCO HACE FALTA ESTE EXTREMO DE LA RELACION. PARA NO CONFUNDIRME LA COMENTO
  #has_many :products, class_name: 'MixBoxDetail', foreign_key: :product_id # si este producto es una mix_box entonces tiene muchos (has_many) items

  has_many :product_prices, inverse_of: :product, dependent: :delete_all
  accepts_nested_attributes_for :product_prices, update_only: true
  accepts_nested_attributes_for :product_boxes, allow_destroy: true
  accepts_nested_attributes_for :mix_box_details, allow_destroy: true

  validates :code, :name, :product_cost, :cargo_cost, :total_cost, presence: true
  validates :code, :name, uniqueness: true
  validates :product_cost, :cargo_cost, :total_cost, numericality: true
  #validates :units_sale_allowed, inclusion: {in: [true, false]}
  validates :is_mix_box, inclusion: {in: [true, false]}

  validate :must_have_2_products_at_least, if: -> {is_mix_box}
  validate :must_have_units_box, if: -> {is_mix_box}
  validate :must_have_boxes, unless: -> {is_mix_box}

  scope :mix_boxes, -> { where(is_mix_box: true) }
  scope :not_mix_boxes, -> { where(is_mix_box: false) } # se necesita que la columna tenga en el migration default: false, para evitar el problema con el nil
  scope :code_and_name, -> { all.map{ |p| ["#{p.code} #{p.name}", p.id] }}

  before_save do
    if self.is_mix_box
      self.units_sale_allowed = true
      self.product_boxes.each { |pb| pb.destroy unless pb.box.is_the_units_box? }
    else
      self.mix_box_details.delete_all
      # si esta la caja UNIDADES se stea a true sino false
      self.units_sale_allowed = self.product_boxes.select{|pb| !pb.marked_for_destruction? && pb.box.is_the_units_box?}.size > 0
    end
    validate_prices
  end

  after_create do
    ProductPrice.transaction do
      CustomerCategory.all.each do |cc|
        product_price = ProductPrice.new(product_id: self.id, customer_category_id: cc.id, profit_percent: cc.profit_percent, sales_commission: cc.sales_commission, price: calculate_product_price(cc))
        product_price.save
      end
    end
  end

  after_update do
    if self.total_cost_changed? || self.product_prices.map(&:changed?)
      ProductPrice.transaction do
        self.product_prices.each do |pp|
          pp.price = calculate_product_price(pp)
          pp.save
        end
      end
    end
  end

  def code_and_name
    "#{code} #{name}"
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  def calculate_product_price(instance)
    if instance.profit_percent && instance.sales_commission
      self.total_cost + (self.total_cost * ((instance.profit_percent + instance.sales_commission).to_f / 100))
    end
  end

  def must_have_2_products_at_least
    products_not_destroyed = self.mix_box_details.select{|pmb| !pmb.marked_for_destruction?}
    unless products_not_destroyed.size > 1
      self.errors.add(:is_mix_box, I18n.t('activerecord.messages.mix_box_without_products'))
      false
    end
    unless products_not_destroyed.map(&:product_id).uniq.size > 1 # productos no repetidos
      self.errors.add(:is_mix_box, I18n.t('activerecord.messages.mix_box_products_not_uniq'))
      self.errors.add(:base, I18n.t('activerecord.messages.mix_box_products_not_uniq'))
      false
    end
  end

  def must_have_units_box
    unless self.product_boxes.select{|pb| !pb.marked_for_destruction? && pb.box.is_the_units_box?}.size > 0
      self.errors.add(:is_mix_box, 'si es caja surtida debe venderse por UNIDADES')
    end
  end

  def must_have_boxes
    unless self.product_boxes.select{|b| !b.marked_for_destruction?}.size > 0
      self.errors.add(:is_mix_box, I18n.t('activerecord.messages.nor_unit_nor_boxes_sales'))
      false
    end
  end

  def validate_prices
    flag = true
    self.product_prices.each do |pp|
      unless pp.valid?
        flag = false
      end
    end
    unless flag
      errors.add(:base, I18n.t('activerecord.errors.template.default_error_base'))
      false
    end
  end

end
