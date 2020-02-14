require 'test_helper'

class CatEreResultsControllerTest < ActionController::TestCase
  setup do
    @cat_ere_result = cat_ere_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ere_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ere_result" do
    assert_difference('CatEreResult.count') do
      post :create, cat_ere_result: { cat_ere_expending_focu_id: @cat_ere_result.cat_ere_expending_focu_id, description: @cat_ere_result.description, key: @cat_ere_result.key }
    end

    assert_redirected_to cat_ere_result_path(assigns(:cat_ere_result))
  end

  test "should show cat_ere_result" do
    get :show, id: @cat_ere_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ere_result
    assert_response :success
  end

  test "should update cat_ere_result" do
    patch :update, id: @cat_ere_result, cat_ere_result: { cat_ere_expending_focu_id: @cat_ere_result.cat_ere_expending_focu_id, description: @cat_ere_result.description, key: @cat_ere_result.key }
    assert_redirected_to cat_ere_result_path(assigns(:cat_ere_result))
  end

  test "should destroy cat_ere_result" do
    assert_difference('CatEreResult.count', -1) do
      delete :destroy, id: @cat_ere_result
    end

    assert_redirected_to cat_ere_results_path
  end
end
