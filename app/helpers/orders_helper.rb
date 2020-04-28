module OrdersHelper
  def options_select_for_product_box(product)
    options_array = product.product_boxes.map {|v| [v.name, v.quantity]}
    options_array.unshift(['', '']) if product.product_boxes.count > 1
    options_array << [t('simple_form.labels.defaults.units_alone'), '0'] if product.units_sale_allowed
    options_array
  end
end
