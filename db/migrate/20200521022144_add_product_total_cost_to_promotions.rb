class AddProductTotalCostToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :product_total_cost, :float
  end
end
