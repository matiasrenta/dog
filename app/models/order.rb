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

  STATUS_TYPES = [['CREADO', 'CREATED'],
                  ['EMPACADO', 'PACKED'],
                  ['ENVIADO', 'SENT'],
                  ['ENTREGADO', 'DELIVERED'],
                  ['COBRADO', 'CHARGED'],
                  ['COMISIONADO', 'COMMISSIONED'],]

  belongs_to :user
  belongs_to :customer
  belongs_to :customer_branch
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true

  before_validation on: :create do
    self.status = STATUS_TYPES[0][1]
    calculate_total_amount
  end

  validates :customer_id, :customer_branch_id, :user_id, :total_amount, :status, presence: true
  validates :customer_id, :customer_branch_id, :user_id, :total_amount, numericality: true

  # todo: esta validacion no muestra un mensaje bueno. la otra validacion no funciona al crearse
  validates_presence_of :order_details, message: 'HOLA'
  validate do |order|
    order.errors.add(:base, :order_details_blank, message: 'Debe haber al menos un detalle') if order.order_details.empty?
  end

  scope :created, -> { where(status: STATUS_TYPES[0][1]) }

  before_save do
    calculate_total_amount
  end

  def self.i18n_status(status)
    s = status || 'CREATED' #todo: quitar esto!! es solo para que funcione debido a que los datos en bbdd estaban mal
    STATUS_TYPES.find { |st| st[1] == status}[0]
  end

  def created?
    self.status == STATUS_TYPES[0][1]
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

  private

  def calculate_total_amount
    self.total_amount = order_details.collect { |od| (od.valid? && !od.marked_for_destruction?) ? (od.quantity * od.unit_price) : 0 }.sum
    self.total_amount = self.total_amount * ((Sett['IVA'].to_f/100) + 1) if self.iva # ((Sett['IVA']/100) + 1) == 1.21
  end
end
