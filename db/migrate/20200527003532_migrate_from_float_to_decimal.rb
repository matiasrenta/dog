class MigrateFromFloatToDecimal < ActiveRecord::Migration
  def up
    change_column :promotions, :product_total_cost,                           :decimal, precision: 10, scale: 2

    change_column :customer_categories, :company_profit_percent,               :decimal, precision: 10, scale: 2
    change_column :customer_categories, :seller_profit_percent,                :decimal, precision: 10, scale: 2
    change_column :customer_categories, :seller_commission_over_price_percent, :decimal, precision: 10, scale: 2
    change_column :customer_categories, :total_profit_percent,                 :decimal, precision: 10, scale: 2

    change_column :order_details, :unit_price,                                :decimal, precision: 10, scale: 2
    change_column :order_details, :subtotal,                                  :decimal, precision: 10, scale: 2

    change_column :orders, :total_amount,                                     :decimal, precision: 10, scale: 2
    change_column :orders, :iva_amount,                                       :decimal, precision: 10, scale: 2

    change_column :prices, :company_profit_percent,                           :decimal, precision: 10, scale: 2
    change_column :prices, :seller_profit_percent,                            :decimal, precision: 10, scale: 2
    change_column :prices, :seller_commission_over_price_percent,             :decimal, precision: 10, scale: 2
    change_column :prices, :price,                                            :decimal, precision: 10, scale: 2
    change_column :prices, :total_profit_percent,                             :decimal, precision: 10, scale: 2

    change_column :product_prices, :price,                                    :decimal, precision: 10, scale: 2
    change_column :product_prices, :profit_percent,                           :decimal, precision: 10, scale: 2
    change_column :product_prices, :sales_commission,                         :decimal, precision: 10, scale: 2

    change_column :products, :product_cost,                                   :decimal, precision: 10, scale: 2
    change_column :products, :cargo_cost,                                     :decimal, precision: 10, scale: 2
    change_column :products, :total_cost,                                     :decimal, precision: 10, scale: 2

    change_column :purchase_order_details, :product_unit_cost,                :decimal, precision: 10, scale: 2
    change_column :purchase_order_details, :box_unit_cost,                    :decimal, precision: 10, scale: 2

    change_column :purchase_orders, :total_amount,                            :decimal, precision: 10, scale: 2

    change_column :things, :price,                                            :decimal, precision: 10, scale: 2
  end

  def down
    # Either change the column back, or mark it as irreversible with:
    raise ActiveRecord::IrreversibleMigration
  end
end

