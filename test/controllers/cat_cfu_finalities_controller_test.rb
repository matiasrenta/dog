require 'test_helper'

class CatCfuFinalitiesControllerTest < ActionController::TestCase
  setup do
    @cat_cfu_finality = cat_cfu_finalities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_cfu_finalities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_cfu_finality" do
    assert_difference('CatCfuFinality.count') do
      post :create, cat_cfu_finality: { description: @cat_cfu_finality.description, key: @cat_cfu_finality.key }
    end

    assert_redirected_to cat_cfu_finality_path(assigns(:cat_cfu_finality))
  end

  test "should show cat_cfu_finality" do
    get :show, id: @cat_cfu_finality
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_cfu_finality
    assert_response :success
  end

  test "should update cat_cfu_finality" do
    patch :update, id: @cat_cfu_finality, cat_cfu_finality: { description: @cat_cfu_finality.description, key: @cat_cfu_finality.key }
    assert_redirected_to cat_cfu_finality_path(assigns(:cat_cfu_finality))
  end

  test "should destroy cat_cfu_finality" do
    assert_difference('CatCfuFinality.count', -1) do
      delete :destroy, id: @cat_cfu_finality
    end

    assert_redirected_to cat_cfu_finalities_path
  end
end
