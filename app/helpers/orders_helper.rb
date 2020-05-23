module OrdersHelper

  def options_select_for_promotion
    Promotion.actives.map{ |p| ["*PROMO* #{p.product.code} #{p.product.name}", p.id] }
  end

  def options_select_for_product
    Product.code_and_name
  end

  def options_select_for_box(product)
    options_array = product.boxes.order(quantity: :asc).map {|v| [v.name, v.quantity]} # chapusa, parche, porque no supe resolverlo con un hidden y un json con todos los datos. El id ahora tiene la cantidad, en el controller o model (no recuerdo) busco el box a partir de la cantidad. una chapuza
    options_array.unshift(['', '']) if product.boxes.count > 1 # le agrego la opcion vacía si hay mas de una caja para elejir
    options_array
  end
end
