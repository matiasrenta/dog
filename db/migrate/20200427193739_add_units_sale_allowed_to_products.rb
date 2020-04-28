class AddUnitsSaleAllowedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :units_sale_allowed, :boolean
  end
end
