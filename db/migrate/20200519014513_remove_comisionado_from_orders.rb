class RemoveComisionadoFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :comisionado, :boolean
  end
end
