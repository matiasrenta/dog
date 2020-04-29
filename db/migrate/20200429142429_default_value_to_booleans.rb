class DefaultValueToBooleans < ActiveRecord::Migration
  def change
    change_column :orders, :iva, :boolean, default: false
    change_column :products, :units_sale_allowed, :boolean, default: false
    change_column :products, :is_mix_box, :boolean, default: false
  end
end
