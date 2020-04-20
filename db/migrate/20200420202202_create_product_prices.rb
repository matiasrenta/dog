class CreateProductPrices < ActiveRecord::Migration
  def change
    create_table :product_prices do |t|
      t.integer :product_id
      t.integer :customer_category_id
      t.float :price

      t.timestamps null: false
    end
  end
end
