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
  has_many :prices, -> { joins(:customer_category).order('customer_categories.order ASC') }, as: :priceable, dependent: :delete_all
  has_many :order_details, dependent: :restrict_with_error
  accepts_nested_attributes_for :prices

  attr_accessor :actual_stock

  scope :published, -> {where(published: true)}
  scope :from_date_has_past, -> {where('from_date >= ?', Date.today)}
  scope :to_date_doesnt_has_past, -> {where('to_date IS NOT NULL AND to_date >= ?', Date.today)}

  scope :into_from_to_dates, -> {from_date_has_past.to_date_doesnt_has_past}

  scope :end_with_date, -> {where(end_with: END_WITH_DATE)}
  scope :end_with_stock, -> {where(end_with: END_WITH_STOCK)}
  scope :end_with_endless, -> {where(end_with: END_WITH_ENDLESS)}
  scope :promo_type_with_stock, -> {where(promo_type: PROMO_TYPE_WITH_STOCK)}
  scope :promo_type_without_stock, -> {where(promo_type: PROMO_TYPE_WITHOUT_STOCK)}

  scope :with_stock_available_stock, ->{promo_type_with_stock.where('quantity_available IS NOT NULL AND quantity_available > 0')}
  scope :without_stock_available_stock, ->{promo_type_without_stock} # hay que pensar el join con Inventory para ver si exists and is bigger than 0

  #scope :actives_end_with_date,

  scope :actives, -> {published}

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

  validates :quantity_start, presence: true, if: -> {with_stock?}
  validates :quantity_start, numericality: true, if: -> {quantity_start.present?}
  validates :quantity_available, numericality: true, if: -> {quantity_available.present?}
  validates :to_date, presence: { message: 'Si finaliza con fecha debe ingresar esa fecha' }, if: -> {end_with_date?}


  before_create do
    self.quantity_available = self.quantity_start
  end

  def with_stock?
    self.promo_type == PROMO_TYPE_WITH_STOCK
  end

  def end_with_date?
    self.end_with == END_WITH_DATE
  end

  def i18n_promo_type
    PROMO_TYPES_FOR_SELECT.find { |e| e[1] == self.promo_type}[0]
  end

  def i18n_end_with
    END_WITH_FOR_SELECT.find { |e| e[1] == self.end_with}[0]
  end

  def stock_available
    #todo:  si es con stoc propioandar ese stock sino el del product/box
    if with_stock?
      self.quantity_available
    else
      self.product.stock_available(self.box_id, self.expiration_date)
    end
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
