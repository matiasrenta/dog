class RemoveProductIdFromOrderDetails < ActiveRecord::Migration
  def change
    remove_column :order_details, :product_box_id, :integer
  end
end
