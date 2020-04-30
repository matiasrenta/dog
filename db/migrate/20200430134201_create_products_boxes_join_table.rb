class CreateProductsBoxesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :products, :boxes do |t|
      t.index [:product_id, :box_id]
      t.index [:box_id, :product_id]
    end
  end
end
