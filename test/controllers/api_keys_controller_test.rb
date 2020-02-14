require 'test_helper'

class ApiKeysControllerTest < ActionController::TestCase
  setup do
    @api_key = api_keys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_keys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_key" do
    assert_difference('ApiKey.count') do
      post :create, api_key: { access_token: @api_key.access_token, application: @api_key.application, note: @api_key.note }
    end

    assert_redirected_to api_key_path(assigns(:api_key))
  end

  test "should show api_key" do
    get :show, id: @api_key
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_key
    assert_response :success
  end

  test "should update api_key" do
    patch :update, id: @api_key, api_key: { access_token: @api_key.access_token, application: @api_key.application, note: @api_key.note }
    assert_redirected_to api_key_path(assigns(:api_key))
  end

  test "should destroy api_key" do
    assert_difference('ApiKey.count', -1) do
      delete :destroy, id: @api_key
    end

    assert_redirected_to api_keys_path
  end
end
