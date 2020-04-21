class AddIvaToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :iva, :boolean
  end
end
