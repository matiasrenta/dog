require 'test_helper'

class CatDerLineOfActionsControllerTest < ActionController::TestCase
  setup do
    @cat_der_line_of_action = cat_der_line_of_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_der_line_of_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_der_line_of_action" do
    assert_difference('CatDerLineOfAction.count') do
      post :create, cat_der_line_of_action: { cat_der_strategy_id: @cat_der_line_of_action.cat_der_strategy_id, description: @cat_der_line_of_action.description, key: @cat_der_line_of_action.key }
    end

    assert_redirected_to cat_der_line_of_action_path(assigns(:cat_der_line_of_action))
  end

  test "should show cat_der_line_of_action" do
    get :show, id: @cat_der_line_of_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_der_line_of_action
    assert_response :success
  end

  test "should update cat_der_line_of_action" do
    patch :update, id: @cat_der_line_of_action, cat_der_line_of_action: { cat_der_strategy_id: @cat_der_line_of_action.cat_der_strategy_id, description: @cat_der_line_of_action.description, key: @cat_der_line_of_action.key }
    assert_redirected_to cat_der_line_of_action_path(assigns(:cat_der_line_of_action))
  end

  test "should destroy cat_der_line_of_action" do
    assert_difference('CatDerLineOfAction.count', -1) do
      delete :destroy, id: @cat_der_line_of_action
    end

    assert_redirected_to cat_der_line_of_actions_path
  end
end
