class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :priceable, polymorphic: true
      t.integer :customer_category_id
      t.float :company_profit_percent
      t.float :seller_profit_percent
      t.float :seller_commission_over_price_percent
      t.float :price
      t.timestamps null: false
    end
  end
end
