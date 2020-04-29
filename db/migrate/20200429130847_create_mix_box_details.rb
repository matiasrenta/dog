class CreateMixBoxDetails < ActiveRecord::Migration
  def change
    create_table :mix_box_details do |t|
      t.integer :mix_box_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
