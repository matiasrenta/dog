class AddSalesCommissionToProductPrices < ActiveRecord::Migration
  def change
    add_column :product_prices, :sales_commission, :float
  end
end
