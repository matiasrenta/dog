require 'test_helper'

class CatFonSpecificSourcesControllerTest < ActionController::TestCase
  setup do
    @cat_fon_specific_source = cat_fon_specific_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_specific_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_specific_source" do
    assert_difference('CatFonSpecificSource.count') do
      post :create, cat_fon_specific_source: { description: @cat_fon_specific_source.description, key: @cat_fon_specific_source.key }
    end

    assert_redirected_to cat_fon_specific_source_path(assigns(:cat_fon_specific_source))
  end

  test "should show cat_fon_specific_source" do
    get :show, id: @cat_fon_specific_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_specific_source
    assert_response :success
  end

  test "should update cat_fon_specific_source" do
    patch :update, id: @cat_fon_specific_source, cat_fon_specific_source: { description: @cat_fon_specific_source.description, key: @cat_fon_specific_source.key }
    assert_redirected_to cat_fon_specific_source_path(assigns(:cat_fon_specific_source))
  end

  test "should destroy cat_fon_specific_source" do
    assert_difference('CatFonSpecificSource.count', -1) do
      delete :destroy, id: @cat_fon_specific_source
    end

    assert_redirected_to cat_fon_specific_sources_path
  end
end
