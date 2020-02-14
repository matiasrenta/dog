require 'test_helper'

class CatEreSubresultsControllerTest < ActionController::TestCase
  setup do
    @cat_ere_subresult = cat_ere_subresults(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ere_subresults)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ere_subresult" do
    assert_difference('CatEreSubresult.count') do
      post :create, cat_ere_subresult: { cat_ere_result_id: @cat_ere_subresult.cat_ere_result_id, description: @cat_ere_subresult.description, key: @cat_ere_subresult.key }
    end

    assert_redirected_to cat_ere_subresult_path(assigns(:cat_ere_subresult))
  end

  test "should show cat_ere_subresult" do
    get :show, id: @cat_ere_subresult
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ere_subresult
    assert_response :success
  end

  test "should update cat_ere_subresult" do
    patch :update, id: @cat_ere_subresult, cat_ere_subresult: { cat_ere_result_id: @cat_ere_subresult.cat_ere_result_id, description: @cat_ere_subresult.description, key: @cat_ere_subresult.key }
    assert_redirected_to cat_ere_subresult_path(assigns(:cat_ere_subresult))
  end

  test "should destroy cat_ere_subresult" do
    assert_difference('CatEreSubresult.count', -1) do
      delete :destroy, id: @cat_ere_subresult
    end

    assert_redirected_to cat_ere_subresults_path
  end
end
