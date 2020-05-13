class RemoveInventoryIdFromInventoryEvents < ActiveRecord::Migration
  def change
    remove_column :inventory_events, :inventory_id, :integer
  end
end
