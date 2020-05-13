class CreateInventoryEvents < ActiveRecord::Migration
  def change
    create_table :inventory_events do |t|
      t.integer :inventory_id
      t.string :event
      t.string :reason
      t.text :notes
      t.integer :entity_id
      t.string :entity_type
      t.text :entity_serialized
      t.integer :quantity
      t.integer :box_id

      t.timestamps null: false
    end
  end
end
