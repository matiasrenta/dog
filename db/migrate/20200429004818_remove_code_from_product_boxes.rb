class RemoveCodeFromProductBoxes < ActiveRecord::Migration
  def change
    remove_column :product_boxes, :code, :string
  end
end
