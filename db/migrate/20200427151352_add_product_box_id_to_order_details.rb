class AddProductBoxIdToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :product_box_id, :integer
  end
end
