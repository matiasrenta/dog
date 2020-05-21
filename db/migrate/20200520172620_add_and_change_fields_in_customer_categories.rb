class AddAndChangeFieldsInCustomerCategories < ActiveRecord::Migration
  def change
    rename_column :customer_categories, :profit_percent, :company_profit_percent
    rename_column :customer_categories, :sales_commission, :seller_profit_percent
    add_column :customer_categories, :seller_commission_over_price_percent, :float
  end
end
