class AddQuantityCountByHumanToInventoryEvents < ActiveRecord::Migration
  def change
    add_column :inventory_events, :quantity_count_by_human, :integer
  end
end
