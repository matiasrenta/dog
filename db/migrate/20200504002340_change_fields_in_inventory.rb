class ChangeFieldsInInventory < ActiveRecord::Migration
  def change
    remove_column :inventories, :quantity, :integer
    add_column :inventories, :quantity_warehouse, :integer
    add_column :inventories, :quantity_available, :integer
  end
end
