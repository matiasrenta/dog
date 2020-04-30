class AddBoxIdToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :box_id, :integer
  end
end
