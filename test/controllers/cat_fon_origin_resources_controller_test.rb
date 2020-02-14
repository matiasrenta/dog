require 'test_helper'

class CatFonOriginResourcesControllerTest < ActionController::TestCase
  setup do
    @cat_fon_origin_resource = cat_fon_origin_resources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_origin_resources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_origin_resource" do
    assert_difference('CatFonOriginResource.count') do
      post :create, cat_fon_origin_resource: { description: @cat_fon_origin_resource.description, key: @cat_fon_origin_resource.key }
    end

    assert_redirected_to cat_fon_origin_resource_path(assigns(:cat_fon_origin_resource))
  end

  test "should show cat_fon_origin_resource" do
    get :show, id: @cat_fon_origin_resource
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_origin_resource
    assert_response :success
  end

  test "should update cat_fon_origin_resource" do
    patch :update, id: @cat_fon_origin_resource, cat_fon_origin_resource: { description: @cat_fon_origin_resource.description, key: @cat_fon_origin_resource.key }
    assert_redirected_to cat_fon_origin_resource_path(assigns(:cat_fon_origin_resource))
  end

  test "should destroy cat_fon_origin_resource" do
    assert_difference('CatFonOriginResource.count', -1) do
      delete :destroy, id: @cat_fon_origin_resource
    end

    assert_redirected_to cat_fon_origin_resources_path
  end
end
