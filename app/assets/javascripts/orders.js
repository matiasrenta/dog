select2_with_matcher_or();
ajax_dropdown($(document));

$('#order_customer_id').on('change', function(event){
    if (this.value == ''){
        $("#div_link_to_add").css('display', 'none');
    }
    else{
        $("#div_link_to_add").css('display', 'block');
    }
});

// cuando elimino un item del formulario calculo el total_amount
$(document).on('nested:fieldRemoved', function(event){
    // this field was just removed from your form
    var field = event.field;
    var subtotal_field = field.find('.subtotal');
    subtotal_field.val(0);
    calculate_total_amount();
});

// cuando se selecciona iva calcula el total_amount
$('#order_iva').change(function() {
    calculate_total_amount();
});

// cuando ingreso cantidad de cajas calculo la cantidad de unidades y luego subtotal y total
$(document).on("input", ".quantity", function() {
    quantity_units_element = this.closest('table').getElementsByClassName('quantity_units')[0];
    quantity_in_the_box = parseInt( $(this.closest('table')).find($("[id$='_quantity_in_the_box']"))[0].value );
    quantity_units_element.value = quantity_in_the_box * parseInt(this.value);
    var subtotal = parseFloat(quantity_units_element.closest('table').getElementsByClassName('unit_price')[0].value) * parseInt(quantity_units_element.value);
    this.closest('table').getElementsByClassName('subtotal')[0].value = subtotal.toFixed(2);
    calculate_total_amount();
});

// cuando ingreso la cantidad calculo el subtotal y sumo todos los subtotales para obtener el total
$(document).on("input", ".quantity_units", function() {
    var subtotal = parseFloat(this.closest('tr').getElementsByClassName('unit_price')[0].value) * parseInt(this.value);
    this.closest('tr').getElementsByClassName('subtotal')[0].value = subtotal.toFixed(2);
    calculate_total_amount();
});


function calculate_total_amount(){
    var sum = 0;
    $(".subtotal").each(function(){
        sum += ( +$(this).val() );
    });

    if (document.getElementById("order_iva").value == 'true'){
        // todo: quitar el hardcoded del 1.21 y usar la sett variable de IVA
        sum = sum * 1.21;
    }
    $("#order_total_amount").val(sum.toFixed(2));
}

// Tuve que cambiar una cosita en esta librería para que si habia una sola sucursal la pusiera como selected directamente
// el archivo que cambie es: js/plugin/dynamic-selectable/dynamic_selectable
$('#order_customer_id').dynamicSelectable();
//$('[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable();

