class AddDisccountAmountToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :disccount_amount, :decimal, precision: 10, scale: 2
  end
end
