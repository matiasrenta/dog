class RemoveFieldsFromInventories < ActiveRecord::Migration
  def change
    remove_column :inventories, :quantity_taken, :integer
    remove_column :inventories, :quantity_warehouse, :integer
  end
end
