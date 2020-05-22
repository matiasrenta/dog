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


// todo:  A PARTIR DE AQUI ES IGUAL A PRODUCTS.JS
// todo: (HAY QUE REFACTORIZAR POR FAVOR!!! es solo el id del total_cost que cambia en products y promotions, y lo demás es que empieza con promotions en vez de products)


// al cambiar total_cost cambian los prices
$('#promotion_product_total_cost').on('input', function() {
    if( $.isNumeric($('#promotion_product_total_cost').val()) ){
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

// calcula: price, company_profit_percent, seller_profit_percent
// en base a: total_cost, total_profit_percent y seller_comm.
function calculate_prices(){
    total_cost = parseFloat($('#promotion_product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        total_profit_percent = parseFloat($('#promotion_prices_attributes_' + i + '_total_profit_percent').val());
        seller_comm  = parseFloat($('#promotion_prices_attributes_' + i + '_seller_commission_over_price_percent').val());

        price = total_cost + (total_cost * (total_profit_percent / 100));
        seller_comm_amount = price * (seller_comm / 100);
        temp_price = price - seller_comm_amount;
        company_profit_percent = ((temp_price - total_cost) / total_cost) * 100;
        seller_profit_percent = total_profit_percent - company_profit_percent;

        $('#promotion_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent);
        $('#promotion_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent);
        $('#promotion_prices_attributes_' + i + '_price').val(price);
    }
}

function calculate_profits(){
    total_cost = parseFloat($('#promotion_product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#promotion_prices_attributes_' + i + '_price').val());
        seller_comm = parseFloat($('#promotion_prices_attributes_' + i + '_seller_commission_over_price_percent').val());

        total_profit_percent = (((price - total_cost) / total_cost) * 100);
        seller_comm_amount = price * (seller_comm / 100);
        temp_price = price - seller_comm_amount;
        company_profit_percent = ((temp_price - total_cost) / total_cost) * 100;
        seller_profit_percent = total_profit_percent - company_profit_percent;

        $('#promotion_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent);
        $('#promotion_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent);
        $('#promotion_prices_attributes_' + i + '_total_profit_percent').val(total_profit_percent);
    }
}


function calculate_seller_profit_and_commision(){
    total_cost = parseFloat($('#promotion_product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#promotion_prices_attributes_' + i + '_price').val());
        total_profit_percent = parseFloat($('#promotion_prices_attributes_' + i + '_total_profit_percent').val());
        company_profit_percent = parseFloat($('#promotion_prices_attributes_' + i + '_company_profit_percent').val());

        seller_profit_percent = total_profit_percent - company_profit_percent;
        seller_comm_amount = total_cost * (seller_profit_percent / 100);
        seller_comm = (seller_comm_amount / price) * 100;

        $('#promotion_prices_attributes_' + i + '_seller_profit_percent').val(seller_profit_percent);
        $('#promotion_prices_attributes_' + i + '_seller_commission_over_price_percent').val(seller_comm);
    }
}

function calculate_company_profit_and_commision(){
    total_cost = parseFloat($('#promotion_product_total_cost').val());
    tppa = $(document).find("input[id$='_total_profit_percent']");

    for(i=0; i < tppa.size(); i++){
        price = parseFloat($('#promotion_prices_attributes_' + i + '_price').val());
        total_profit_percent = parseFloat($('#promotion_prices_attributes_' + i + '_total_profit_percent').val());
        seller_profit_percent = parseFloat($('#promotion_prices_attributes_' + i + '_seller_profit_percent').val());

        company_profit_percent = total_profit_percent - seller_profit_percent;
        seller_comm_amount = total_cost * (seller_profit_percent / 100);
        seller_comm = (seller_comm_amount / price) * 100;

        $('#promotion_prices_attributes_' + i + '_company_profit_percent').val(company_profit_percent);
        $('#promotion_prices_attributes_' + i + '_seller_commission_over_price_percent').val(seller_comm);
    }
}



