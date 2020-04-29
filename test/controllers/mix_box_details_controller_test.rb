require 'test_helper'

class MixBoxDetailsControllerTest < ActionController::TestCase
  setup do
    @mix_box_detail = mix_box_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mix_box_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mix_box_detail" do
    assert_difference('MixBoxDetail.count') do
      post :create, mix_box_detail: { mix_box_id: @mix_box_detail.mix_box_id, product_id: @mix_box_detail.product_id, quantity: @mix_box_detail.quantity }
    end

    assert_redirected_to mix_box_detail_path(assigns(:mix_box_detail))
  end

  test "should show mix_box_detail" do
    get :show, id: @mix_box_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mix_box_detail
    assert_response :success
  end

  test "should update mix_box_detail" do
    patch :update, id: @mix_box_detail, mix_box_detail: { mix_box_id: @mix_box_detail.mix_box_id, product_id: @mix_box_detail.product_id, quantity: @mix_box_detail.quantity }
    assert_redirected_to mix_box_detail_path(assigns(:mix_box_detail))
  end

  test "should destroy mix_box_detail" do
    assert_difference('MixBoxDetail.count', -1) do
      delete :destroy, id: @mix_box_detail
    end

    assert_redirected_to mix_box_details_path
  end
end
