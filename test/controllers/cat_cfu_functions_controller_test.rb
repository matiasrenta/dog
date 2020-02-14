require 'test_helper'

class CatCfuFunctionsControllerTest < ActionController::TestCase
  setup do
    @cat_cfu_function = cat_cfu_functions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_cfu_functions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_cfu_function" do
    assert_difference('CatCfuFunction.count') do
      post :create, cat_cfu_function: { cat_cfu_finality_id: @cat_cfu_function.cat_cfu_finality_id, description: @cat_cfu_function.description, key: @cat_cfu_function.key }
    end

    assert_redirected_to cat_cfu_function_path(assigns(:cat_cfu_function))
  end

  test "should show cat_cfu_function" do
    get :show, id: @cat_cfu_function
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_cfu_function
    assert_response :success
  end

  test "should update cat_cfu_function" do
    patch :update, id: @cat_cfu_function, cat_cfu_function: { cat_cfu_finality_id: @cat_cfu_function.cat_cfu_finality_id, description: @cat_cfu_function.description, key: @cat_cfu_function.key }
    assert_redirected_to cat_cfu_function_path(assigns(:cat_cfu_function))
  end

  test "should destroy cat_cfu_function" do
    assert_difference('CatCfuFunction.count', -1) do
      delete :destroy, id: @cat_cfu_function
    end

    assert_redirected_to cat_cfu_functions_path
  end
end
