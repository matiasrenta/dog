class Order < ActiveRecord::Base
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




  STATUS_CREATED      = 'CREATED'
  STATUS_PACKED       = 'PACKED'
  STATUS_DISPATCHED   = 'DISPATCHED'
  STATUS_DELIVERED    = 'DELIVERED'
  STATUS_CHARGED      = 'CHARGED'
  STATUS_ACCOUNTED    = 'ACCOUNTED'
  STATUS_COMMISSIONED = 'COMMISSIONED'
  STATUS_CANCELED     = 'CANCELED'

  STATUS_TYPES = [['CREADO', STATUS_CREATED],
                  ['EMPACADO', STATUS_PACKED],
                  ['DESPACHADO', STATUS_DISPATCHED],
                  ['ENTREGADO', STATUS_DELIVERED],
                  ['COBRADO', STATUS_CHARGED],
                  ['CONTABILIZADO', STATUS_ACCOUNTED],
                  ['COMISIONADO', STATUS_COMMISSIONED],
                  ['CANCELADO', STATUS_CANCELED]]


  state_machine :status, initial: :CREATED do
    #store_audit_trail

    event :PACKED do
      transition CREATED: :PACKED
    end

    event :DISPATCHED do
      transition PACKED: :DISPATCHED
    end

    event :DELIVERED do
      transition DISPATCHED: :DELIVERED
    end

    event :CHARGED do
      transition DELIVERED: :CHARGED
      transition DISPATCHED: :CHARGED
    end

    event :ACCOUNTED do
      transition CHARGED: :ACCOUNTED
    end

    event :COMMISSIONED do
      transition ACCOUNTED: :COMMISSIONED
    end

    event :CANCELED do
      transition PACKED: :CANCELED
      transition DISPATCHED: :CANCELED
    end

    after_transition [:PACKED, :DISPATCHED] => :CANCELED do |order, transition|
      self.order_details.each do |od|
        # agrego al stock lo que se quitó cuando se creó esta entidad
        Inventory.update_stock({product_id: od.product_id,
                                box_id: od.box_id,
                                quantity: od.quantity,
                                event: InventoryEvent::EVENT_ADD,
                                reason: InventoryEvent::REASON_ORDER_CANCELED})

      end
    end
  end


  belongs_to :user
  belongs_to :customer
  belongs_to :customer_branch
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true

  #before_validation on: :create do
  #  self.status = STATUS_CREATED
  #end

  validates :customer_id, :customer_branch_id, :user_id, :total_amount, :status, presence: true
  validates :customer_id, :customer_branch_id, :user_id, :total_amount, numericality: true
  #validates :status, inclusion: {in: STATUS_TYPES.map{|s| s[1]}}

  # todo: esta validacion no muestra un mensaje bueno. la otra validacion no funciona al crearse
  validates_presence_of :order_details, message: 'HOLA'
  validate do |order|
    order.errors.add(:base, :order_details_blank, message: 'Debe haber al menos un detalle') if order.order_details.empty?
  end

  scope :created, -> { where(status: STATUS_CREATED) }

  #before_update do
  #  if self.status_changed? && self.canceled?
  #    #todo: no qiuiero que de created lo pasen a canceled. pero no me da bola al quereer hacer el destroy aqui dentro de update, ni retornando false lo destruye, pero si destruye los order_details
  #    #self.destroy if self.status_was == STATUS_CREATED
  #    self.order_details.each do |od|
  #      # agrego al stock lo que se quitó cuando se creó esta entidad
  #      Inventory.update_stock({product_id: od.product_id,
  #                              box_id: od.box_id,
  #                              quantity: od.quantity,
  #                              event: InventoryEvent::EVENT_ADD,
  #                              reason: InventoryEvent::REASON_ORDER_CANCELED})
  #    end
  #  end
  #end

  before_destroy do
    unless self.created?
      errors.add(:base, "Solo pedidos en status #{Order.i18n_status(STATUS_CREATED)} pueden ser eliminados. Pero se puede CANCELAR cambiando su status a #{Order.i18n_status(STATUS_CANCELED)}")
      false
    end
  end

  #un array con solo los status que van a la bbdd
  def self.system_status_array
    STATUS_TYPES.map{|s| s[1]}
  end

  def self.i18n_status(status)
    STATUS_TYPES.find { |st| st[1] == status}[0]
  end

  def created?
    self.status == STATUS_CREATED
  end

  def canceled?
    self.status == STATUS_CANCELED
  end

  def i18n_status
    STATUS_TYPES.find { |e| e[1] == self.status}[0]
  end

  def product_codes
    order_details.includes(:product).map(){|e| e.product.try(:code)}
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

#  def calculate_total_amount
#    self.total_amount = order_details.collect { |od| (od.valid? && !od.marked_for_destruction?) ? (od.quantity * od.unit_price) : 0 }.sum
#    self.total_amount = self.total_amount * ((Sett['IVA'].to_f/100) + 1) if self.iva # ((Sett['IVA']/100) + 1) == 1.21
#  end

end
