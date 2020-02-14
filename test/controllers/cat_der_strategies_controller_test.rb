require 'test_helper'

class CatDerStrategiesControllerTest < ActionController::TestCase
  setup do
    @cat_der_strategy = cat_der_strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_der_strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_der_strategy" do
    assert_difference('CatDerStrategy.count') do
      post :create, cat_der_strategy: { cat_der_human_right_id: @cat_der_strategy.cat_der_human_right_id, description: @cat_der_strategy.description, key: @cat_der_strategy.key }
    end

    assert_redirected_to cat_der_strategy_path(assigns(:cat_der_strategy))
  end

  test "should show cat_der_strategy" do
    get :show, id: @cat_der_strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_der_strategy
    assert_response :success
  end

  test "should update cat_der_strategy" do
    patch :update, id: @cat_der_strategy, cat_der_strategy: { cat_der_human_right_id: @cat_der_strategy.cat_der_human_right_id, description: @cat_der_strategy.description, key: @cat_der_strategy.key }
    assert_redirected_to cat_der_strategy_path(assigns(:cat_der_strategy))
  end

  test "should destroy cat_der_strategy" do
    assert_difference('CatDerStrategy.count', -1) do
      delete :destroy, id: @cat_der_strategy
    end

    assert_redirected_to cat_der_strategies_path
  end
end
