require 'test_helper'

class CatPgdObjectivesControllerTest < ActionController::TestCase
  setup do
    @cat_pgd_objective = cat_pgd_objectives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_pgd_objectives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_pgd_objective" do
    assert_difference('CatPgdObjective.count') do
      post :create, cat_pgd_objective: { cat_pgd_area_of_opportunity_id: @cat_pgd_objective.cat_pgd_area_of_opportunity_id, description: @cat_pgd_objective.description, key: @cat_pgd_objective.key }
    end

    assert_redirected_to cat_pgd_objective_path(assigns(:cat_pgd_objective))
  end

  test "should show cat_pgd_objective" do
    get :show, id: @cat_pgd_objective
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_pgd_objective
    assert_response :success
  end

  test "should update cat_pgd_objective" do
    patch :update, id: @cat_pgd_objective, cat_pgd_objective: { cat_pgd_area_of_opportunity_id: @cat_pgd_objective.cat_pgd_area_of_opportunity_id, description: @cat_pgd_objective.description, key: @cat_pgd_objective.key }
    assert_redirected_to cat_pgd_objective_path(assigns(:cat_pgd_objective))
  end

  test "should destroy cat_pgd_objective" do
    assert_difference('CatPgdObjective.count', -1) do
      delete :destroy, id: @cat_pgd_objective
    end

    assert_redirected_to cat_pgd_objectives_path
  end
end
