require 'test_helper'

class CatFonFundsControllerTest < ActionController::TestCase
  setup do
    @cat_fon_fund = cat_fon_funds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_funds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_fund" do
    assert_difference('CatFonFund.count') do
      post :create, cat_fon_fund: { cat_fon_funding_source_id: @cat_fon_fund.cat_fon_funding_source_id, cat_fon_generic_source_id: @cat_fon_fund.cat_fon_generic_source_id, cat_fon_origin_resource_id: @cat_fon_fund.cat_fon_origin_resource_id, cat_fon_specific_source_id: @cat_fon_fund.cat_fon_specific_source_id, cat_fon_year_document_id: @cat_fon_fund.cat_fon_year_document_id, description: @cat_fon_fund.description, key: @cat_fon_fund.key }
    end

    assert_redirected_to cat_fon_fund_path(assigns(:cat_fon_fund))
  end

  test "should show cat_fon_fund" do
    get :show, id: @cat_fon_fund
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_fund
    assert_response :success
  end

  test "should update cat_fon_fund" do
    patch :update, id: @cat_fon_fund, cat_fon_fund: { cat_fon_funding_source_id: @cat_fon_fund.cat_fon_funding_source_id, cat_fon_generic_source_id: @cat_fon_fund.cat_fon_generic_source_id, cat_fon_origin_resource_id: @cat_fon_fund.cat_fon_origin_resource_id, cat_fon_specific_source_id: @cat_fon_fund.cat_fon_specific_source_id, cat_fon_year_document_id: @cat_fon_fund.cat_fon_year_document_id, description: @cat_fon_fund.description, key: @cat_fon_fund.key }
    assert_redirected_to cat_fon_fund_path(assigns(:cat_fon_fund))
  end

  test "should destroy cat_fon_fund" do
    assert_difference('CatFonFund.count', -1) do
      delete :destroy, id: @cat_fon_fund
    end

    assert_redirected_to cat_fon_funds_path
  end
end
