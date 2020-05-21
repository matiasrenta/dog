class AddOrderToCustomerCategories < ActiveRecord::Migration
  def change
    add_column :customer_categories, :order, :integer
  end
end
