// cuando se ingresa algo a los inputs de coste de flete o costo de producto se calcula el costo total

$('#product_product_cost').on('input', function() {
    calculate_total_cost();
});

$('#product_cargo_cost').on('input', function() {
    calculate_total_cost();
});

function calculate_total_cost(){
    if( $.isNumeric($('#product_product_cost').val()) && $.isNumeric($('#product_cargo_cost').val()) ){
        $('#product_total_cost').val(parseFloat($('#product_product_cost').val()) + parseFloat($('#product_cargo_cost').val()));
    }
    else {
        $('#product_total_cost').val('');
    }
}

// cuando ingreso el margen de ganancia (profit_percent) calculo el precio
$(document).on("input", "input[id$='_profit_percent']", function() {
    profit_percent = parseFloat(this.value);
    product_total_cost = parseFloat($("#product_total_cost").val());
    price = product_total_cost + (product_total_cost * (profit_percent / 100));
    product_price_element = $( this.closest('tr') ).find("input[id$='_price']")[0];
    product_price_element.value = price;
});

// cuando ingreso el precio calculo el margen de ganancia (profit_percent)
$(document).on("input", "input[id$='_price']", function() {
    price = parseFloat(this.value);
    product_total_cost = parseFloat($("#product_total_cost").val());
    profit_percent = ((price - product_total_cost) / product_total_cost) * 100
    product_price_element = $( this.closest('tr') ).find("input[id$='_profit_percent']")[0];
    product_price_element.value = profit_percent;
});

