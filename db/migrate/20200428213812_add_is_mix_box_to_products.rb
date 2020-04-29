class AddIsMixBoxToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_mix_box, :boolean
  end
end
