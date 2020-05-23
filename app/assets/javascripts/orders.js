select2_with_or_matcher();
ajax_dropdown($(document));

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


//$('.box').change(function() {
//    quantity_in_the_box = this.closest('td').getElementsByClassName('quantity_in_the_box')[0].value
//});

// cuando cambio de caja limpio las cantidades y abilito/desabilito las cantidades
$(document).on("change", ".box", function() {
    box_value = this.value;
    quantity_element = this.closest('tr').getElementsByClassName('quantity')[0];
    quantity_units_element = this.closest('table').getElementsByClassName('quantity_units')[0];

    quantity_element.value = '';
    quantity_units_element.value = '';
    this.closest('table').getElementsByClassName('subtotal')[0].value = '';
    calculate_total_amount();

    if (box_value == '' || parseInt(box_value) > 0){
        quantity_units_element.readOnly = true;
        quantity_element.readOnly = false;
    }
    else{
        quantity_element.readOnly = true;
        quantity_units_element.readOnly = false;
    }
});


// cuando ingreso cantidad de cajas calculo la cantidad de unidades
$(document).on("input", ".quantity", function() {
    quantity_units_element = this.closest('table').getElementsByClassName('quantity_units')[0];
    box_value = parseInt( this.closest('table').getElementsByClassName('box')[0].value );
    quantity_units_element.value = box_value * parseInt(this.value);
    //quantity_units_element.trigger("input");
    var subtotal = parseFloat(quantity_units_element.closest('table').getElementsByClassName('unit_price')[0].value) * parseInt(quantity_units_element.value);
    this.closest('table').getElementsByClassName('subtotal')[0].value = subtotal;
    calculate_total_amount();
});

// cuando ingreso la cantidad calculo el subtotal y sumo todos los subtotales para obtener el total
$(document).on("input", ".quantity_units", function() {
    var subtotal = parseFloat(this.closest('tr').getElementsByClassName('unit_price')[0].value) * parseInt(this.value);
    this.closest('tr').getElementsByClassName('subtotal')[0].value = subtotal;
    calculate_total_amount();
});


function calculate_total_amount(){
    var sum = 0;
    $(".subtotal").each(function(){
        sum += ( +$(this).val() );
    });

    if (document.getElementById("order_iva").checked){
        // todo: quitar el hardcoded del 1.21 y usar la sett variable de IVA
        sum = sum * 1.21;
    }
    $("#order_total_amount").val(sum);
}

// Tuve que cambiar una cosita en esta librería para que si habia una sola sucursal la pusiera como selected directamente
// el archivo que cambie es: js/plugin/dynamic-selectable/dynamic_selectable
$('#order_customer_id').dynamicSelectable();
//$('[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable();

$('#order_customer_id').select2({
    containerCssClass: "matutecon",
    dropdownCssClass: "matutondrop",
});
