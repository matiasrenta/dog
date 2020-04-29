class AddProfitPercentToProductPrices < ActiveRecord::Migration
  def change
    add_column :product_prices, :profit_percent, :float
  end
end
