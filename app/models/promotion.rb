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
  scope :from_date_has_past, -> {where('from_date <= ?', Date.today)}
  scope :into_dates_or_endless, -> {from_date_has_past.where('to_date IS NULL OR end_with = ? OR to_date >= ?', END_WITH_ENDLESS, Date.today)}
  scope :in_stock, -> {
    where('(promo_type = ? AND quantity_available > 0)
          OR
           (promo_type = ?
            AND EXISTS (select *
                      from inventories
                     where inventories.product_id = promotions.product_id
                       and inventories.box_id = promotions.box_id
                       and promotions.expiration_date IS NULL OR inventories.expiration_date = promotions.expiration_date
                       and inventories.quantity_available > 0))', PROMO_TYPE_WITH_STOCK, PROMO_TYPE_WITHOUT_STOCK)
  }
  scope :actives, -> {published.into_dates_or_endless.in_stock}

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
    if with_stock?
      # quito el stock del inventario para ponerselo a esta promo
      Inventory.update_stock({product_id: self.product_id,
                              box_id: self.box_id,
                              expiration_date: self.expiration_date,
                              quantity: self.quantity_start,
                              event: InventoryEvent::EVENT_REMOVE,
                              reason: InventoryEvent::REASON_PROMOTION})
    end
    self.quantity_available = self.quantity_start
  end

  after_destroy do
    if with_stock? && stock_available > 0
      # agrego al stock lo que tiene en stock. Debería ser igual al quantity_start porque no debería existir ningun pedido sobre esta promo. sino no podría eliminarse (solo soft delete)
      Inventory.update_stock({product_id: self.product_id,
                              box_id: self.box_id,
                              expiration_date: self.expiration_date,
                              quantity: self.quantity,
                              event: InventoryEvent::EVENT_ADD,
                              reason: InventoryEvent::REASON_PROMO_DESTROY})
    end
  end

  def active?
    Promotion.actives.include?(self)
  end

  def promo_type_with_stock?
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
    if with_stock?
      self.quantity_available
    else
      self.product.stock_available(self.box_id, self.expiration_date)
    end
  end

  def update_stock(q)
    if with_stock?
      self.quantity_available = q
      save
    else
      Inventory.update_stock({product_id: self.product_id,
                              box_id: self.box_id,
                              expiration_date: self.expiration_date,
                              quantity: q,
                              event: InventoryEvent::EVENT_REMOVE,
                              reason: InventoryEvent::REASON_SALE})
    end
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
