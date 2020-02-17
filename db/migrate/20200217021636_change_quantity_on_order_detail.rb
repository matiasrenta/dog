class ChangeQuantityOnOrderDetail < ActiveRecord::Migration
  def change
    remove_column :order_details, :quantity
    add_column :order_details,  :quantity, :integer
  end
end
