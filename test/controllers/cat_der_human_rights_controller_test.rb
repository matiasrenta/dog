require 'test_helper'

class CatDerHumanRightsControllerTest < ActionController::TestCase
  setup do
    @cat_der_human_right = cat_der_human_rights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_der_human_rights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_der_human_right" do
    assert_difference('CatDerHumanRight.count') do
      post :create, cat_der_human_right: { description: @cat_der_human_right.description, key: @cat_der_human_right.key }
    end

    assert_redirected_to cat_der_human_right_path(assigns(:cat_der_human_right))
  end

  test "should show cat_der_human_right" do
    get :show, id: @cat_der_human_right
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_der_human_right
    assert_response :success
  end

  test "should update cat_der_human_right" do
    patch :update, id: @cat_der_human_right, cat_der_human_right: { description: @cat_der_human_right.description, key: @cat_der_human_right.key }
    assert_redirected_to cat_der_human_right_path(assigns(:cat_der_human_right))
  end

  test "should destroy cat_der_human_right" do
    assert_difference('CatDerHumanRight.count', -1) do
      delete :destroy, id: @cat_der_human_right
    end

    assert_redirected_to cat_der_human_rights_path
  end
end
