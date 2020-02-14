require 'test_helper'

class CatFonYearDocumentsControllerTest < ActionController::TestCase
  setup do
    @cat_fon_year_document = cat_fon_year_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_fon_year_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_fon_year_document" do
    assert_difference('CatFonYearDocument.count') do
      post :create, cat_fon_year_document: { description: @cat_fon_year_document.description, key: @cat_fon_year_document.key }
    end

    assert_redirected_to cat_fon_year_document_path(assigns(:cat_fon_year_document))
  end

  test "should show cat_fon_year_document" do
    get :show, id: @cat_fon_year_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_fon_year_document
    assert_response :success
  end

  test "should update cat_fon_year_document" do
    patch :update, id: @cat_fon_year_document, cat_fon_year_document: { description: @cat_fon_year_document.description, key: @cat_fon_year_document.key }
    assert_redirected_to cat_fon_year_document_path(assigns(:cat_fon_year_document))
  end

  test "should destroy cat_fon_year_document" do
    assert_difference('CatFonYearDocument.count', -1) do
      delete :destroy, id: @cat_fon_year_document
    end

    assert_redirected_to cat_fon_year_documents_path
  end
end
