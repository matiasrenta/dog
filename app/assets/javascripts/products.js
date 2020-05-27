// cuando se ingresa algo a los inputs de coste de flete o costo de producto se calcula el costo total
// al cambiar total_cost cambian los prices
$('#product_product_cost, #product_cargo_cost').on('input', function() {
    calculate_total_cost();
    if( $.isNumeric($('#product_total_cost').val()) ){
        calculate_prices();
    }
});

// al cambiar los total_profit_percent o los seller_commission_over_price_percent
$("[id$='_total_profit_percent'], [id$='_seller_commission_over_price_percent']").on('input', function() {
    calculate_prices();
});

// si se cambia el precio cambia el total_profit_percent y el company_profit_percent (pero NO cambia el seller_profit_percent)
$("[id$='_price']").on('input', function() {
    calculate_profits();
});

$("[id$='_company_profit_percent']").on('input', function() {
    calculate_seller_profit_and_commision();
});

$("[id$='_seller_profit_percent']").on('input', function() {
    calculate_company_profit_and_commision();
});


function calculate_total_cost(){
    if( $.isNumeric($('#product_product_cost').val()) && $.isNumeric($('#product_cargo_cost').val()) ){
        product_total_cost = parseFloat($('#product_product_cost').val()) + parseFloat($('#product_cargo_cost').val());
        $('#product_total_cost').val(product_total_cost.toFixed(2));
    }
    else {
        $('#product_total_cost').val('');
    }
}

// calcula: price, company_profit_percent, seller_profit_percent
// en base a: total_cost, total_profit_percent y seller_comm.
function calculate_prices(){
    total_cost = parseFloat($('#product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        total_profit_percent = parseFloat($('#product_prices_attributes_' + i + '_total_profit_percent').val());
        seller_comm  = parseFloat($('#product_prices_attributes_' + i + '_seller_commission_over_price_percent').val());

        price = total_cost + (total_cost * (total_profit_percent / 100));
        seller_comm_amount = price * (seller_comm / 100);
        temp_price = price - seller_comm_amount;
        company_profit_percent = ((temp_price - total_cost) / total_cost) * 100;
        seller_profit_percent = total_profit_percent - company_profit_percent;

        $('#product_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_price').val(price.toFixed(2));
    }
}

function calculate_profits(){
    total_cost = parseFloat($('#product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#product_prices_attributes_' + i + '_price').val());
        seller_comm = parseFloat($('#product_prices_attributes_' + i + '_seller_commission_over_price_percent').val());

        total_profit_percent = (((price - total_cost) / total_cost) * 100);
        seller_comm_amount = price * (seller_comm / 100);
        temp_price = price - seller_comm_amount;
        company_profit_percent = ((temp_price - total_cost) / total_cost) * 100;
        seller_profit_percent = total_profit_percent - company_profit_percent;

        $('#product_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_total_profit_percent').val(total_profit_percent.toFixed(2));
    }
}


function calculate_seller_profit_and_commision(){
    total_cost = parseFloat($('#product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#product_prices_attributes_' + i + '_price').val());
        total_profit_percent = parseFloat($('#product_prices_attributes_' + i + '_total_profit_percent').val());
        company_profit_percent = parseFloat($('#product_prices_attributes_' + i + '_company_profit_percent').val());

        seller_profit_percent = total_profit_percent - company_profit_percent;
        seller_comm_amount = total_cost * (seller_profit_percent / 100);
        seller_comm = (seller_comm_amount / price) * 100;

        $('#product_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_seller_commission_over_price_percent').val(seller_comm.toFixed(2));
    }
}

function calculate_company_profit_and_commision(){
    total_cost = parseFloat($('#product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#product_prices_attributes_' + i + '_price').val());
        total_profit_percent = parseFloat($('#product_prices_attributes_' + i + '_total_profit_percent').val());
        seller_profit_percent = parseFloat($('#product_prices_attributes_' + i + '_seller_profit_percent').val());

        company_profit_percent = total_profit_percent - seller_profit_percent;
        seller_comm_amount = total_cost * (seller_profit_percent / 100);
        seller_comm = (seller_comm_amount / price) * 100;

        $('#product_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent.toFixed(2));
        $('#product_prices_attributes_' + i + '_seller_commission_over_price_percent').val(seller_comm.toFixed(2));
    }
}

// cuando cambia el select de mix_box
$(document).on("change", "#product_is_mix_box", function() {
    if (this.value == 'true') {
        $("#mix_box").css('display', 'block');
    } else {
        $("#mix_box").css('display', 'none');
    }
});









