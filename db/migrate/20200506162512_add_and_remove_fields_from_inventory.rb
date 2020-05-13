class AddAndRemoveFieldsFromInventory < ActiveRecord::Migration
  def change
    remove_column :inventories, :quantity_in_units, :integer
    add_column :inventories, :quantity_available_in_units, :integer
  end
end
