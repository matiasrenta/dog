class ProductMixBox < ActiveRecord::Base
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


  belongs_to :mix_box, class_name: 'Product'#, primary_key: :product_id
  belongs_to :product, class_name: 'Product'#, primary_key: :product_id


  validates :product_id, :quantity, presence: true
  validates :product_id, :quantity, numericality: true




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end