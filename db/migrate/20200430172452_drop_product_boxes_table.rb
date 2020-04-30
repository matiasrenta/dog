class DropProductBoxesTable < ActiveRecord::Migration
  def change
    drop_table :product_boxes
  end
end
