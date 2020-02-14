require 'test_helper'

class CatFonFundingSourcesControllerTest < ActionController::TestCase
  setup do
    @cat_fon_funding_source = cat_fon_funding_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_funding_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_funding_source" do
    assert_difference('CatFonFundingSource.count') do
      post :create, cat_fon_funding_source: { description: @cat_fon_funding_source.description, key: @cat_fon_funding_source.key }
    end

    assert_redirected_to cat_fon_funding_source_path(assigns(:cat_fon_funding_source))
  end

  test "should show cat_fon_funding_source" do
    get :show, id: @cat_fon_funding_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_funding_source
    assert_response :success
  end

  test "should update cat_fon_funding_source" do
    patch :update, id: @cat_fon_funding_source, cat_fon_funding_source: { description: @cat_fon_funding_source.description, key: @cat_fon_funding_source.key }
    assert_redirected_to cat_fon_funding_source_path(assigns(:cat_fon_funding_source))
  end

  test "should destroy cat_fon_funding_source" do
    assert_difference('CatFonFundingSource.count', -1) do
      delete :destroy, id: @cat_fon_funding_source
    end

    assert_redirected_to cat_fon_funding_sources_path
  end
end
