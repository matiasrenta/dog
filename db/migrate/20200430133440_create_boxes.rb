class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
