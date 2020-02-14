require 'test_helper'

class CatCfuSubfunctionsControllerTest < ActionController::TestCase
  setup do
    @cat_cfu_subfunction = cat_cfu_subfunctions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_cfu_subfunctions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_cfu_subfunction" do
    assert_difference('CatCfuSubfunction.count') do
      post :create, cat_cfu_subfunction: { cat_cfu_function_id: @cat_cfu_subfunction.cat_cfu_function_id, description: @cat_cfu_subfunction.description, key: @cat_cfu_subfunction.key }
    end

    assert_redirected_to cat_cfu_subfunction_path(assigns(:cat_cfu_subfunction))
  end

  test "should show cat_cfu_subfunction" do
    get :show, id: @cat_cfu_subfunction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_cfu_subfunction
    assert_response :success
  end

  test "should update cat_cfu_subfunction" do
    patch :update, id: @cat_cfu_subfunction, cat_cfu_subfunction: { cat_cfu_function_id: @cat_cfu_subfunction.cat_cfu_function_id, description: @cat_cfu_subfunction.description, key: @cat_cfu_subfunction.key }
    assert_redirected_to cat_cfu_subfunction_path(assigns(:cat_cfu_subfunction))
  end

  test "should destroy cat_cfu_subfunction" do
    assert_difference('CatCfuSubfunction.count', -1) do
      delete :destroy, id: @cat_cfu_subfunction
    end

    assert_redirected_to cat_cfu_subfunctions_path
  end
end
