class RemoveStocksFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :quantity_stock, :integer
    remove_column :products, :quantity_min, :integer
    remove_column :products, :quantity_max, :integer
    remove_column :products, :saleman_fee_percent, :integer
  end
end
