class RemoveCustomerBranchIdFromOrderDetails < ActiveRecord::Migration
  def change
    remove_column :order_details, :customer_branch_id, :integer
  end
end
