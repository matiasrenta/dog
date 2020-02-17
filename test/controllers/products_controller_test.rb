require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { cargo_cost: @product.cargo_cost, code: @product.code, name: @product.name, product_cost: @product.product_cost, profit_percent: @product.profit_percent, quantity_max: @product.quantity_max, quantity_min: @product.quantity_min, quantity_stock: @product.quantity_stock, sale_price: @product.sale_price, saleman_fee_percent: @product.saleman_fee_percent, total_cost: @product.total_cost }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { cargo_cost: @product.cargo_cost, code: @product.code, name: @product.name, product_cost: @product.product_cost, profit_percent: @product.profit_percent, quantity_max: @product.quantity_max, quantity_min: @product.quantity_min, quantity_stock: @product.quantity_stock, sale_price: @product.sale_price, saleman_fee_percent: @product.saleman_fee_percent, total_cost: @product.total_cost }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
