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

  STATUS_TYPES = [['Creado', 'Creado'],
                  ['Empaquetado', 'Empaquetado'],
                  ['Entregado', 'Entregado'],
                  ['Cobrado', 'Cobrado']]

  belongs_to :user
  belongs_to :customer
  belongs_to :customer_branch
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true

  before_validation on: :create do
    self.status = STATUS_TYPES[0][1]
  end

  validates :customer_id, :customer_branch_id, :user_id, :total_amount, :status, presence: true
  validates :customer_id, :customer_branch_id, :user_id, :total_amount, numericality: true

  # todo: esta validacion no muestra un mensaje bueno. la otra validacion no funciona al crearse
  validates_presence_of :order_details, message: 'HOLA'
  validate do |order|
    order.errors.add(:base, :order_details_blank, message: 'Debe haber al menos un detalle') if order.order_details.empty?
  end

  before_save do
    self.total_amount = order_details.collect { |od| od.valid? ? (od.quantity * od.unit_price) : 0 }.sum
  end


  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
