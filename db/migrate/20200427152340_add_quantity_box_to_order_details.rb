class AddQuantityBoxToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :quantity_box, :integer
  end
end
