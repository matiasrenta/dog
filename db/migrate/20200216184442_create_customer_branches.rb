class CreateCustomerBranches < ActiveRecord::Migration
  def change
    create_table :customer_branches do |t|
      t.integer :customer_id
      t.string :name
      t.string :address
      t.text :notes

      t.timestamps null: false
    end
  end
end
