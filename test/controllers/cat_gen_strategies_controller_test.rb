require 'test_helper'

class CatGenStrategiesControllerTest < ActionController::TestCase
  setup do
    @cat_gen_strategy = cat_gen_strategies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_gen_strategies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_gen_strategy" do
    assert_difference('CatGenStrategy.count') do
      post :create, cat_gen_strategy: { cat_gen_objective_id: @cat_gen_strategy.cat_gen_objective_id, description: @cat_gen_strategy.description, key: @cat_gen_strategy.key }
    end

    assert_redirected_to cat_gen_strategy_path(assigns(:cat_gen_strategy))
  end

  test "should show cat_gen_strategy" do
    get :show, id: @cat_gen_strategy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_gen_strategy
    assert_response :success
  end

  test "should update cat_gen_strategy" do
    patch :update, id: @cat_gen_strategy, cat_gen_strategy: { cat_gen_objective_id: @cat_gen_strategy.cat_gen_objective_id, description: @cat_gen_strategy.description, key: @cat_gen_strategy.key }
    assert_redirected_to cat_gen_strategy_path(assigns(:cat_gen_strategy))
  end

  test "should destroy cat_gen_strategy" do
    assert_difference('CatGenStrategy.count', -1) do
      delete :destroy, id: @cat_gen_strategy
    end

    assert_redirected_to cat_gen_strategies_path
  end
end
