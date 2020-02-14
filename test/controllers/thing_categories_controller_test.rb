require 'test_helper'

class ThingCategoriesControllerTest < ActionController::TestCase
  setup do
    @thing_category = thing_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thing_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thing_category" do
    assert_difference('ThingCategory.count') do
      post :create, thing_category: { name: @thing_category.name }
    end

    assert_redirected_to thing_category_path(assigns(:thing_category))
  end

  test "should show thing_category" do
    get :show, id: @thing_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @thing_category
    assert_response :success
  end

  test "should update thing_category" do
    patch :update, id: @thing_category, thing_category: { name: @thing_category.name }
    assert_redirected_to thing_category_path(assigns(:thing_category))
  end

  test "should destroy thing_category" do
    assert_difference('ThingCategory.count', -1) do
      delete :destroy, id: @thing_category
    end

    assert_redirected_to thing_categories_path
  end
end
