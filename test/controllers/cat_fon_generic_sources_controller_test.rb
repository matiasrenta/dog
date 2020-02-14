require 'test_helper'

class CatFonGenericSourcesControllerTest < ActionController::TestCase
  setup do
    @cat_fon_generic_source = cat_fon_generic_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_generic_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_generic_source" do
    assert_difference('CatFonGenericSource.count') do
      post :create, cat_fon_generic_source: { description: @cat_fon_generic_source.description, key: @cat_fon_generic_source.key }
    end

    assert_redirected_to cat_fon_generic_source_path(assigns(:cat_fon_generic_source))
  end

  test "should show cat_fon_generic_source" do
    get :show, id: @cat_fon_generic_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_generic_source
    assert_response :success
  end

  test "should update cat_fon_generic_source" do
    patch :update, id: @cat_fon_generic_source, cat_fon_generic_source: { description: @cat_fon_generic_source.description, key: @cat_fon_generic_source.key }
    assert_redirected_to cat_fon_generic_source_path(assigns(:cat_fon_generic_source))
  end

  test "should destroy cat_fon_generic_source" do
    assert_difference('CatFonGenericSource.count', -1) do
      delete :destroy, id: @cat_fon_generic_source
    end

    assert_redirected_to cat_fon_generic_sources_path
  end
end
