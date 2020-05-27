// al cambiar los total_profit_percent o los seller_commission_over_price_percent
$('#customer_category_total_profit_percent, #customer_category_seller_commission_over_price_percent').on('input', function() {
    calculate_profits();
});


function calculate_profits(){
    total_cost = 1000
    total_profit = parseFloat($('#customer_category_total_profit_percent').val());
    seller_comm  = parseFloat($('#customer_category_seller_commission_over_price_percent').val());

    price = total_cost + (total_cost * (total_profit / 100));
    seller_comm_amount = price * (seller_comm / 100);
    temp_price = price - seller_comm_amount;
    company_profit_percent = ((temp_price - total_cost) / total_cost) * 100;
    seller_profit_percent = total_profit - company_profit_percent;

    $('#customer_category_company_profit_percent').val(company_profit_percent.toFixed(2));
    $('#customer_category_seller_profit_percent').val(seller_profit_percent.toFixed(2));
}









