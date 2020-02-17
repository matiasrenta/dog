class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :user_id
      t.float :total_amount
      t.string :status
      t.boolean :comisionado
      t.datetime :delivery_date

      t.timestamps null: false
    end
  end
end
