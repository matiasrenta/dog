class CreatePurchaseOrderDetails < ActiveRecord::Migration
  def change
    create_table :purchase_order_details do |t|
      t.integer :box_id
      t.integer :quantity
      t.float :product_unit_cost
      t.float :box_unit_cost
      t.integer :purchase_order_id

      t.timestamps null: false
    end
  end
end
