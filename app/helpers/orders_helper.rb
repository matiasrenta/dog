module OrdersHelper
  def options_select_for_box(product)
    options_array = product.boxes.order(quantity: :asc).map {|v| [v.name, v.quantity]}
    options_array.unshift(['', '']) if product.boxes.count > 1 # le agrego la opcion vacía si hay mas de una caja para elejir
    #options_array << [t('simple_form.labels.defaults.units_alone'), 0] if product.units_sale_allowed
    options_array
  end
end
