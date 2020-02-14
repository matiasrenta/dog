require 'test_helper'

class CatGenAxisControllerTest < ActionController::TestCase
  setup do
    @cat_gen_axi = cat_gen_axis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_gen_axis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_gen_axi" do
    assert_difference('CatGenAxi.count') do
      post :create, cat_gen_axi: { description: @cat_gen_axi.description, key: @cat_gen_axi.key }
    end

    assert_redirected_to cat_gen_axi_path(assigns(:cat_gen_axi))
  end

  test "should show cat_gen_axi" do
    get :show, id: @cat_gen_axi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_gen_axi
    assert_response :success
  end

  test "should update cat_gen_axi" do
    patch :update, id: @cat_gen_axi, cat_gen_axi: { description: @cat_gen_axi.description, key: @cat_gen_axi.key }
    assert_redirected_to cat_gen_axi_path(assigns(:cat_gen_axi))
  end

  test "should destroy cat_gen_axi" do
    assert_difference('CatGenAxi.count', -1) do
      delete :destroy, id: @cat_gen_axi
    end

    assert_redirected_to cat_gen_axis_path
  end
end
