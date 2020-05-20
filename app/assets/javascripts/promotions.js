// para que se carguen las cajas segun el producto
$('#promotion_product_id').dynamicSelectable();

// cuando cambia el select de promotion_type, show or hide quantity
$(document).on("change", "#promotion_promo_type", function() {
    if (this.value == 'WITH_STOCK') {
        $("#with_stock").css('display', 'block');
    } else {
        //$("#product_units_sale_allowed").val("false");
        $("#with_stock").css('display', 'none');
    }
});


// cuando cambia el select de end_with, show or hide to_date
$(document).on("change", "#promotion_end_with", function() {
    if (this.value == 'TO_DATE') {
        $("#to_date").css('display', 'block');
    } else {
        $("#to_date").css('display', 'none');
    }
});




