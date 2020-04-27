class CreateProductBoxes < ActiveRecord::Migration
  def change
    create_table :product_boxes do |t|
      t.integer :product_id
      t.string :code
      t.string :name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
