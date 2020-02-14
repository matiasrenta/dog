require 'test_helper'

class CatPgdGoalsControllerTest < ActionController::TestCase
  setup do
    @cat_pgd_goal = cat_pgd_goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_pgd_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_pgd_goal" do
    assert_difference('CatPgdGoal.count') do
      post :create, cat_pgd_goal: { cat_pgd_objective_id: @cat_pgd_goal.cat_pgd_objective_id, description: @cat_pgd_goal.description, key: @cat_pgd_goal.key }
    end

    assert_redirected_to cat_pgd_goal_path(assigns(:cat_pgd_goal))
  end

  test "should show cat_pgd_goal" do
    get :show, id: @cat_pgd_goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_pgd_goal
    assert_response :success
  end

  test "should update cat_pgd_goal" do
    patch :update, id: @cat_pgd_goal, cat_pgd_goal: { cat_pgd_objective_id: @cat_pgd_goal.cat_pgd_objective_id, description: @cat_pgd_goal.description, key: @cat_pgd_goal.key }
    assert_redirected_to cat_pgd_goal_path(assigns(:cat_pgd_goal))
  end

  test "should destroy cat_pgd_goal" do
    assert_difference('CatPgdGoal.count', -1) do
      delete :destroy, id: @cat_pgd_goal
    end

    assert_redirected_to cat_pgd_goals_path
  end
end
