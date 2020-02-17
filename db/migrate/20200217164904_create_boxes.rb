class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :code
      t.integer :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
