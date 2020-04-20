class CreateCustomerCategories < ActiveRecord::Migration
  def change
    create_table :customer_categories do |t|
      t.string :name
      t.integer :profit_percent

      t.timestamps null: false
    end
  end
end
