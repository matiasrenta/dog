require 'test_helper'

class AscriptionsControllerTest < ActionController::TestCase
  setup do
    @ascription = ascriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ascriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ascription" do
    assert_difference('Ascription.count') do
      post :create, ascription: { name: @ascription.name }
    end

    assert_redirected_to ascription_path(assigns(:ascription))
  end

  test "should show ascription" do
    get :show, id: @ascription
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ascription
    assert_response :success
  end

  test "should update ascription" do
    patch :update, id: @ascription, ascription: { name: @ascription.name }
    assert_redirected_to ascription_path(assigns(:ascription))
  end

  test "should destroy ascription" do
    assert_difference('Ascription.count', -1) do
      delete :destroy, id: @ascription
    end

    assert_redirected_to ascriptions_path
  end
end
