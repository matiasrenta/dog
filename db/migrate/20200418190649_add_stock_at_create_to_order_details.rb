class AddStockAtCreateToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :stock_at_create, :integer
  end
end
