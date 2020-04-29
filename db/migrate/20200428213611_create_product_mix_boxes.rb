class CreateProductMixBoxes < ActiveRecord::Migration
  def change
    create_table :product_mix_boxes do |t|
      t.integer :mix_box_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
