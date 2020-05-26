class AddIvaAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :iva_amount, :float
  end
end
