require 'test_helper'

class NominaDocumentsControllerTest < ActionController::TestCase
  setup do
    @nomina_document = nomina_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nomina_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nomina_document" do
    assert_difference('NominaDocument.count') do
      post :create, nomina_document: { file_content_type: @nomina_document.file_content_type, file_filename: @nomina_document.file_filename, file_id: @nomina_document.file_id, file_size: @nomina_document.file_size, month: @nomina_document.month, year: @nomina_document.year }
    end

    assert_redirected_to nomina_document_path(assigns(:nomina_document))
  end

  test "should show nomina_document" do
    get :show, id: @nomina_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nomina_document
    assert_response :success
  end

  test "should update nomina_document" do
    patch :update, id: @nomina_document, nomina_document: { file_content_type: @nomina_document.file_content_type, file_filename: @nomina_document.file_filename, file_id: @nomina_document.file_id, file_size: @nomina_document.file_size, month: @nomina_document.month, year: @nomina_document.year }
    assert_redirected_to nomina_document_path(assigns(:nomina_document))
  end

  test "should destroy nomina_document" do
    assert_difference('NominaDocument.count', -1) do
      delete :destroy, id: @nomina_document
    end

    assert_redirected_to nomina_documents_path
  end
end
