require 'test_helper'

class FinancialDocumentsControllerTest < ActionController::TestCase
  setup do
    @financial_document = financial_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:financial_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create financial_document" do
    assert_difference('FinancialDocument.count') do
      post :create, financial_document: { amount: @financial_document.amount, code: @financial_document.code, doc_date: @financial_document.doc_date, project_activity_id: @financial_document.project_activity_id, provider: @financial_document.provider, type: @financial_document.type }
    end

    assert_redirected_to financial_document_path(assigns(:financial_document))
  end

  test "should show financial_document" do
    get :show, id: @financial_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @financial_document
    assert_response :success
  end

  test "should update financial_document" do
    patch :update, id: @financial_document, financial_document: { amount: @financial_document.amount, code: @financial_document.code, doc_date: @financial_document.doc_date, project_activity_id: @financial_document.project_activity_id, provider: @financial_document.provider, type: @financial_document.type }
    assert_redirected_to financial_document_path(assigns(:financial_document))
  end

  test "should destroy financial_document" do
    assert_difference('FinancialDocument.count', -1) do
      delete :destroy, id: @financial_document
    end

    assert_redirected_to financial_documents_path
  end
end
