// cuando se ingresa algo a los inputs de coste de flete o costo de producto se calcula el costo total

$('#product_product_cost').on('input', function() {
    calculate_total_cost_and_price();
});
$('#product_cargo_cost').on('input', function() {
    calculate_total_cost_and_price();
});
$('#product_profit_percent').on('input', function() {
    calculate_total_cost_and_price();
});

$('#product_sale_price').on('input', function() {
    if($.isNumeric($('#product_total_cost').val()) && $.isNumeric($('#product_sale_price').val()) ){
        var sale_price = parseFloat($('#product_sale_price').val());
        var total_cost = parseFloat($('#product_total_cost').val());
        $('#product_profit_percent').val( ((sale_price - total_cost) / total_cost) * 100 );
    }
});


function calculate_total_cost_and_price(){
    if( $.isNumeric($('#product_product_cost').val()) && $.isNumeric($('#product_cargo_cost').val()) ){
        $('#product_total_cost').val(parseFloat($('#product_product_cost').val()) + parseFloat($('#product_cargo_cost').val()));
    }
    else {
        $('#product_total_cost').val('');
    }


    if($.isNumeric($('#product_total_cost').val()) && $.isNumeric($('#product_profit_percent').val()) ){
        var total_cost = parseFloat($('#product_total_cost').val());
        var profit_percent = parseFloat($('#product_profit_percent').val());
        $('#product_sale_price').val( total_cost + (total_cost * (profit_percent/100)));
    }
    else{
        $('#product_sale_price').val('');
    }
}


