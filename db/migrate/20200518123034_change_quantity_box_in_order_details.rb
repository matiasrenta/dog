class ChangeQuantityBoxInOrderDetails < ActiveRecord::Migration
  def change
    rename_column :order_details, :quantity_box, :quantity_units
  end
end
