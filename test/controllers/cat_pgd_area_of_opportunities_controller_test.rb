require 'test_helper'

class CatPgdAreaOfOpportunitiesControllerTest < ActionController::TestCase
  setup do
    @cat_pgd_area_of_opportunity = cat_pgd_area_of_opportunities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_pgd_area_of_opportunities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_pgd_area_of_opportunity" do
    assert_difference('CatPgdAreaOfOpportunity.count') do
      post :create, cat_pgd_area_of_opportunity: { cat_pgd_axi_id: @cat_pgd_area_of_opportunity.cat_pgd_axi_id, description: @cat_pgd_area_of_opportunity.description, key: @cat_pgd_area_of_opportunity.key }
    end

    assert_redirected_to cat_pgd_area_of_opportunity_path(assigns(:cat_pgd_area_of_opportunity))
  end

  test "should show cat_pgd_area_of_opportunity" do
    get :show, id: @cat_pgd_area_of_opportunity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_pgd_area_of_opportunity
    assert_response :success
  end

  test "should update cat_pgd_area_of_opportunity" do
    patch :update, id: @cat_pgd_area_of_opportunity, cat_pgd_area_of_opportunity: { cat_pgd_axi_id: @cat_pgd_area_of_opportunity.cat_pgd_axi_id, description: @cat_pgd_area_of_opportunity.description, key: @cat_pgd_area_of_opportunity.key }
    assert_redirected_to cat_pgd_area_of_opportunity_path(assigns(:cat_pgd_area_of_opportunity))
  end

  test "should destroy cat_pgd_area_of_opportunity" do
    assert_difference('CatPgdAreaOfOpportunity.count', -1) do
      delete :destroy, id: @cat_pgd_area_of_opportunity
    end

    assert_redirected_to cat_pgd_area_of_opportunities_path
  end
end
