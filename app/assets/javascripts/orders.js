$(document).on('nested:fieldAdded', function(event){
    // this field was just inserted into your form
    var field = event.field;
    // it's a jQuery object already! Now you can find date input
    var fields_disabled = field.find('.enable_me');
    fields_disabled.prop("disabled", false);
});

$(document).on('nested:fieldRemoved', function(event){
    // this field was just removed from your form
    var field = event.field;
    var subtotal_field = field.find('.subtotal');
    subtotal_field.val(0);
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
    $("#order_total_amount").val(sum);

}

