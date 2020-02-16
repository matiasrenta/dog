class CreateCustomerContacts < ActiveRecord::Migration
  def change
    create_table :customer_contacts do |t|
      t.string :name
      t.string :phones
      t.string :email
      t.text :notes
      t.integer :customer_id

      t.timestamps null: false
    end
  end
end
