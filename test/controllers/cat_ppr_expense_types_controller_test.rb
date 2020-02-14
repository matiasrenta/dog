require 'test_helper'

class CatPprExpenseTypesControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_expense_type = cat_ppr_expense_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_expense_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_expense_type" do
    assert_difference('CatPprExpenseType.count') do
      post :create, cat_ppr_expense_type: { description: @cat_ppr_expense_type.description, key: @cat_ppr_expense_type.key }
    end

    assert_redirected_to cat_ppr_expense_type_path(assigns(:cat_ppr_expense_type))
  end

  test "should show cat_ppr_expense_type" do
    get :show, id: @cat_ppr_expense_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_expense_type
    assert_response :success
  end

  test "should update cat_ppr_expense_type" do
    patch :update, id: @cat_ppr_expense_type, cat_ppr_expense_type: { description: @cat_ppr_expense_type.description, key: @cat_ppr_expense_type.key }
    assert_redirected_to cat_ppr_expense_type_path(assigns(:cat_ppr_expense_type))
  end

  test "should destroy cat_ppr_expense_type" do
    assert_difference('CatPprExpenseType.count', -1) do
      delete :destroy, id: @cat_ppr_expense_type
    end

    assert_redirected_to cat_ppr_expense_types_path
  end
end
