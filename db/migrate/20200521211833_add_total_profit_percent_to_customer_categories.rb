class AddTotalProfitPercentToCustomerCategories < ActiveRecord::Migration
  def change
    add_column :customer_categories, :total_profit_percent, :float
    change_column :customer_categories, :company_profit_percent, :float
    change_column :customer_categories, :seller_profit_percent, :float
  end
end
