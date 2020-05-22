class Box < ActiveRecord::Base
  has_many :promotions, dependent: :restrict_with_error
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

  default_scope {order(quantity: :asc)}

  has_many :inventory_events, dependent: :restrict_with_error
  has_many :Inventories, dependent: :restrict_with_error
  has_and_belongs_to_many :products, -> { where is_mix_box: false }, join_table: 'boxes_products'

  validates :name, :quantity, presence: true
  validates :name, uniqueness: true
  validates :quantity, uniqueness: true
  validates :quantity, numericality: true

  UNITS_BOX_NAME = 'UNIDADES'


  def self.units_box
    Box.find_by_name(UNITS_BOX_NAME)
  end

  def is_the_units_box?
    self.name == UNITS_BOX_NAME
  end

  def except_attr_in_public_activity
    [:id, :updated_at]
  end


end
