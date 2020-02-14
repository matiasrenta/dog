require 'test_helper'

class FinancialDocumentTypesControllerTest < ActionController::TestCase
  setup do
    @financial_document_type = financial_document_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:financial_document_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create financial_document_type" do
    assert_difference('FinancialDocumentType.count') do
      post :create, financial_document_type: { description: @financial_document_type.description, name: @financial_document_type.name }
    end

    assert_redirected_to financial_document_type_path(assigns(:financial_document_type))
  end

  test "should show financial_document_type" do
    get :show, id: @financial_document_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @financial_document_type
    assert_response :success
  end

  test "should update financial_document_type" do
    patch :update, id: @financial_document_type, financial_document_type: { description: @financial_document_type.description, name: @financial_document_type.name }
    assert_redirected_to financial_document_type_path(assigns(:financial_document_type))
  end

  test "should destroy financial_document_type" do
    assert_difference('FinancialDocumentType.count', -1) do
      delete :destroy, id: @financial_document_type
    end

    assert_redirected_to financial_document_types_path
  end
end
