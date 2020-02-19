require 'test_helper'

class PurchaseOrderDetailsControllerTest < ActionController::TestCase
  setup do
    @purchase_order_detail = purchase_order_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_order_detail" do
    assert_difference('PurchaseOrderDetail.count') do
      post :create, purchase_order_detail: { box_id: @purchase_order_detail.box_id, box_unit_cost: @purchase_order_detail.box_unit_cost, product_unit_cost: @purchase_order_detail.product_unit_cost, purchase_order_id: @purchase_order_detail.purchase_order_id, quantity: @purchase_order_detail.quantity }
    end

    assert_redirected_to purchase_order_detail_path(assigns(:purchase_order_detail))
  end

  test "should show purchase_order_detail" do
    get :show, id: @purchase_order_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_order_detail
    assert_response :success
  end

  test "should update purchase_order_detail" do
    patch :update, id: @purchase_order_detail, purchase_order_detail: { box_id: @purchase_order_detail.box_id, box_unit_cost: @purchase_order_detail.box_unit_cost, product_unit_cost: @purchase_order_detail.product_unit_cost, purchase_order_id: @purchase_order_detail.purchase_order_id, quantity: @purchase_order_detail.quantity }
    assert_redirected_to purchase_order_detail_path(assigns(:purchase_order_detail))
  end

  test "should destroy purchase_order_detail" do
    assert_difference('PurchaseOrderDetail.count', -1) do
      delete :destroy, id: @purchase_order_detail
    end

    assert_redirected_to purchase_order_details_path
  end
end
