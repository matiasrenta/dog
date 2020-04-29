require 'test_helper'

class ProductMixBoxesControllerTest < ActionController::TestCase
  setup do
    @product_mix_box = product_mix_boxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_mix_boxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_mix_box" do
    assert_difference('ProductMixBox.count') do
      post :create, product_mix_box: { mix_box_id: @product_mix_box.mix_box_id, product_id: @product_mix_box.product_id, quantity: @product_mix_box.quantity }
    end

    assert_redirected_to product_mix_box_path(assigns(:product_mix_box))
  end

  test "should show product_mix_box" do
    get :show, id: @product_mix_box
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_mix_box
    assert_response :success
  end

  test "should update product_mix_box" do
    patch :update, id: @product_mix_box, product_mix_box: { mix_box_id: @product_mix_box.mix_box_id, product_id: @product_mix_box.product_id, quantity: @product_mix_box.quantity }
    assert_redirected_to product_mix_box_path(assigns(:product_mix_box))
  end

  test "should destroy product_mix_box" do
    assert_difference('ProductMixBox.count', -1) do
      delete :destroy, id: @product_mix_box
    end

    assert_redirected_to product_mix_boxes_path
  end
end
