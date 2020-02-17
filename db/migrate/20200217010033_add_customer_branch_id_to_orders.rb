class AddCustomerBranchIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :customer_branch_id, :integer
  end
end
