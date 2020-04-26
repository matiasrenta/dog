class DropTableBoxes < ActiveRecord::Migration
  def change
    drop_table :boxes
  end
end
