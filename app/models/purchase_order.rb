class PurchaseOrder < ActiveRecord::Base
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


  belongs_to :supplier
  has_many :purchase_order_details, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_details, allow_destroy: true

  validates :supplier_id, :total_amount, :status, presence: true
  validates :supplier_id, :total_amount, numericality: true




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end
