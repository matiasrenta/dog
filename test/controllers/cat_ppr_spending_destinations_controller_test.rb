require 'test_helper'

class CatPprSpendingDestinationsControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_spending_destination = cat_ppr_spending_destinations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_spending_destinations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_spending_destination" do
    assert_difference('CatPprSpendingDestination.count') do
      post :create, cat_ppr_spending_destination: { description: @cat_ppr_spending_destination.description, key: @cat_ppr_spending_destination.key }
    end

    assert_redirected_to cat_ppr_spending_destination_path(assigns(:cat_ppr_spending_destination))
  end

  test "should show cat_ppr_spending_destination" do
    get :show, id: @cat_ppr_spending_destination
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_spending_destination
    assert_response :success
  end

  test "should update cat_ppr_spending_destination" do
    patch :update, id: @cat_ppr_spending_destination, cat_ppr_spending_destination: { description: @cat_ppr_spending_destination.description, key: @cat_ppr_spending_destination.key }
    assert_redirected_to cat_ppr_spending_destination_path(assigns(:cat_ppr_spending_destination))
  end

  test "should destroy cat_ppr_spending_destination" do
    assert_difference('CatPprSpendingDestination.count', -1) do
      delete :destroy, id: @cat_ppr_spending_destination
    end

    assert_redirected_to cat_ppr_spending_destinations_path
  end
end
