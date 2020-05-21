class AddTotalProfitPercentToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :total_profit_percent, :float
  end
end
