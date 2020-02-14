require 'test_helper'

class CatAreAreasControllerTest < ActionController::TestCase
  setup do
    @cat_are_area = cat_are_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_are_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_are_area" do
    assert_difference('CatAreArea.count') do
      post :create, cat_are_area: { description: @cat_are_area.description, key: @cat_are_area.key }
    end

    assert_redirected_to cat_are_area_path(assigns(:cat_are_area))
  end

  test "should show cat_are_area" do
    get :show, id: @cat_are_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_are_area
    assert_response :success
  end

  test "should update cat_are_area" do
    patch :update, id: @cat_are_area, cat_are_area: { description: @cat_are_area.description, key: @cat_are_area.key }
    assert_redirected_to cat_are_area_path(assigns(:cat_are_area))
  end

  test "should destroy cat_are_area" do
    assert_difference('CatAreArea.count', -1) do
      delete :destroy, id: @cat_are_area
    end

    assert_redirected_to cat_are_areas_path
  end
end
