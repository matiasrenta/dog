require 'test_helper'

class ProductBoxesControllerTest < ActionController::TestCase
  setup do
    @product_box = product_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_box" do
    assert_difference('ProductBox.count') do
      post :create, product_box: { code: @product_box.code, name: @product_box.name, product_id: @product_box.product_id, quantity: @product_box.quantity }
    end

    assert_redirected_to product_box_path(assigns(:product_box))
  end

  test "should show product_box" do
    get :show, id: @product_box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_box
    assert_response :success
  end

  test "should update product_box" do
    patch :update, id: @product_box, product_box: { code: @product_box.code, name: @product_box.name, product_id: @product_box.product_id, quantity: @product_box.quantity }
    assert_redirected_to product_box_path(assigns(:product_box))
  end

  test "should destroy product_box" do
    assert_difference('ProductBox.count', -1) do
      delete :destroy, id: @product_box
    end

    assert_redirected_to product_boxes_path
  end
end
