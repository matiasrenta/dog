require 'test_helper'

class CatPgdAxisControllerTest < ActionController::TestCase
  setup do
    @cat_pgd_axi = cat_pgd_axis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_pgd_axis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_pgd_axi" do
    assert_difference('CatPgdAxi.count') do
      post :create, cat_pgd_axi: { description: @cat_pgd_axi.description, key: @cat_pgd_axi.key }
    end

    assert_redirected_to cat_pgd_axi_path(assigns(:cat_pgd_axi))
  end

  test "should show cat_pgd_axi" do
    get :show, id: @cat_pgd_axi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_pgd_axi
    assert_response :success
  end

  test "should update cat_pgd_axi" do
    patch :update, id: @cat_pgd_axi, cat_pgd_axi: { description: @cat_pgd_axi.description, key: @cat_pgd_axi.key }
    assert_redirected_to cat_pgd_axi_path(assigns(:cat_pgd_axi))
  end

  test "should destroy cat_pgd_axi" do
    assert_difference('CatPgdAxi.count', -1) do
      delete :destroy, id: @cat_pgd_axi
    end

    assert_redirected_to cat_pgd_axis_path
  end
end
