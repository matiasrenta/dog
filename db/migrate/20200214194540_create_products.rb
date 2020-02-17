class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.integer :quantity_stock
      t.integer :quantity_min
      t.integer :quantity_max
      t.float :product_cost
      t.float :cargo_cost
      t.float :total_cost
      t.float :sale_price
      t.integer :profit_percent
      t.integer :saleman_fee_percent

      t.timestamps null: false
    end
  end
end
