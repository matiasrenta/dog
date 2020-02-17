class AddSubtotalToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :subtotal, :float
  end
end
