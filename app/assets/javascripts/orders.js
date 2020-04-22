// cuando agrego item en el formulario le quito los campos disabled
$(document).on('nested:fieldAdded', function(event){
    // this field was just inserted into your form
    var field = event.field;
    // it's a jQuery object already! Now you can find date input
    var fields_disabled = field.find('.enable_me');
    fields_disabled.prop("disabled", false);
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

// cuando ingreso la cantidad calculo el subtotal y sumo todos los subtotales para obtener el total
$(document).on("input", ".quantity", function() {
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

