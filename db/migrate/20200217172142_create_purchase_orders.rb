class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer :supplier_id
      t.float :total_amount
      t.string :status
      t.text :notes

      t.timestamps null: false
    end
  end
end
