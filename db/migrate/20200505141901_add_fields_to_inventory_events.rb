class AddFieldsToInventoryEvents < ActiveRecord::Migration
  def change
    add_column :inventory_events, :product_id, :integer
    add_column :inventory_events, :expiration_date, :date
  end
end
