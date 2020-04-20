class RemoveSalePriceAndProfitPercentFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :profit_percent, :integer
    remove_column :products, :sale_price, :float
  end
end
