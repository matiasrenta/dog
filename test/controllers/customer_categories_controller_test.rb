require 'test_helper'

class CustomerCategoriesControllerTest < ActionController::TestCase
  setup do
    @customer_category = customer_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_category" do
    assert_difference('CustomerCategory.count') do
      post :create, customer_category: { name: @customer_category.name, profit_percent: @customer_category.profit_percent }
    end

    assert_redirected_to customer_category_path(assigns(:customer_category))
  end

  test "should show customer_category" do
    get :show, id: @customer_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_category
    assert_response :success
  end

  test "should update customer_category" do
    patch :update, id: @customer_category, customer_category: { name: @customer_category.name, profit_percent: @customer_category.profit_percent }
    assert_redirected_to customer_category_path(assigns(:customer_category))
  end

  test "should destroy customer_category" do
    assert_difference('CustomerCategory.count', -1) do
      delete :destroy, id: @customer_category
    end

    assert_redirected_to customer_categories_path
  end
end
