class DropTableProductMixBoxes < ActiveRecord::Migration
  def change
    drop_table :product_mix_boxes
  end
end
