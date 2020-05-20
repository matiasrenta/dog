class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer :product_id
      t.integer :box_id
      t.date :expiration_date
      t.integer :quantity_start
      t.integer :quantity_available
      t.date :from_date
      t.string :end_with
      t.date :to_date
      t.string :name
      t.text :notes
      t.string :promo_type

      t.timestamps null: false
    end
  end
end
