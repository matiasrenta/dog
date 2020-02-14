require 'test_helper'

class CatPprDigitIdentifiersControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_digit_identifier = cat_ppr_digit_identifiers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_digit_identifiers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_digit_identifier" do
    assert_difference('CatPprDigitIdentifier.count') do
      post :create, cat_ppr_digit_identifier: { description: @cat_ppr_digit_identifier.description, key: @cat_ppr_digit_identifier.key }
    end

    assert_redirected_to cat_ppr_digit_identifier_path(assigns(:cat_ppr_digit_identifier))
  end

  test "should show cat_ppr_digit_identifier" do
    get :show, id: @cat_ppr_digit_identifier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_digit_identifier
    assert_response :success
  end

  test "should update cat_ppr_digit_identifier" do
    patch :update, id: @cat_ppr_digit_identifier, cat_ppr_digit_identifier: { description: @cat_ppr_digit_identifier.description, key: @cat_ppr_digit_identifier.key }
    assert_redirected_to cat_ppr_digit_identifier_path(assigns(:cat_ppr_digit_identifier))
  end

  test "should destroy cat_ppr_digit_identifier" do
    assert_difference('CatPprDigitIdentifier.count', -1) do
      delete :destroy, id: @cat_ppr_digit_identifier
    end

    assert_redirected_to cat_ppr_digit_identifiers_path
  end
end
