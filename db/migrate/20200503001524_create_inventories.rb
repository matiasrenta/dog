class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.string :lot
      t.date :expiration_date
      t.integer :quantity
      t.integer :box_id
      t.integer :quantity_taken
      t.integer :quantity_in_units

      t.timestamps null: false
    end
  end
end
