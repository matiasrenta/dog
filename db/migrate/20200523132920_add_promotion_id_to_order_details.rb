class AddPromotionIdToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :promotion_id, :integer
  end
end
