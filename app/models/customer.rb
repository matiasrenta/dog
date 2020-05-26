class Customer < ActiveRecord::Base
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

  belongs_to :customer_category
  belongs_to :user
  has_many :orders, dependent: :restrict_with_error
  has_many :customer_contacts, dependent: :destroy
  has_many :customer_branches, dependent: :destroy

  accepts_nested_attributes_for :customer_contacts, allow_destroy: true
  accepts_nested_attributes_for :customer_branches, allow_destroy: true

  validates :code, :name, :customer_category_id, presence: true
  validates :code, :name, uniqueness: true

  # todo: esta validacion no muestra un mensaje bueno. la otra validacion no funciona al crearse
  validates_presence_of :customer_branches, message: 'HOLA'
  validate do |customer|
    customer.errors.add(:base, :customer_branches_blank, message: 'Debe haber al menos una sucursal') if customer.customer_branches.empty?
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end

end





