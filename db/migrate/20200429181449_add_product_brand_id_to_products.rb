class AddProductBrandIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_brand_id, :integer
  end
end
