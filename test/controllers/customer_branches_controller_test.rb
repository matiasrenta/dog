require 'test_helper'

class CustomerBranchesControllerTest < ActionController::TestCase
  setup do
    @customer_branch = customer_branches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_branches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_branch" do
    assert_difference('CustomerBranch.count') do
      post :create, customer_branch: { address: @customer_branch.address, customer_id: @customer_branch.customer_id, name: @customer_branch.name, notes: @customer_branch.notes }
    end

    assert_redirected_to customer_branch_path(assigns(:customer_branch))
  end

  test "should show customer_branch" do
    get :show, id: @customer_branch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_branch
    assert_response :success
  end

  test "should update customer_branch" do
    patch :update, id: @customer_branch, customer_branch: { address: @customer_branch.address, customer_id: @customer_branch.customer_id, name: @customer_branch.name, notes: @customer_branch.notes }
    assert_redirected_to customer_branch_path(assigns(:customer_branch))
  end

  test "should destroy customer_branch" do
    assert_difference('CustomerBranch.count', -1) do
      delete :destroy, id: @customer_branch
    end

    assert_redirected_to customer_branches_path
  end
end
