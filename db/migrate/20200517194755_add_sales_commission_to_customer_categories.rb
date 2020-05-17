class AddSalesCommissionToCustomerCategories < ActiveRecord::Migration
  def change
    add_column :customer_categories, :sales_commission, :integer
  end
end
