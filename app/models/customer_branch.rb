class CustomerBranch < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  #tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }


  belongs_to :customer
  has_many :orders, dependent: :nullify

  validates :name, :address, presence: true
  validates :name, uniqueness: { scope: :customer_id }

  #before_destroy do
  #  if self.customer.customer_branches.count <= 1 && !self.customer.marked_for_destruction?
  #    self.errors.add(:base, :customer_id, message: 'Debe haber al menos una sucursal')
  #    false
  #  end
  #end




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
