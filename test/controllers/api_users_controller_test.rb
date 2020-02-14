require 'test_helper'

class ApiUsersControllerTest < ActionController::TestCase
  setup do
    @api_user = api_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_user" do
    assert_difference('ApiUser.count') do
      post :create, api_user: { avatar_content_type: @api_user.avatar_content_type, avatar_filename: @api_user.avatar_filename, avatar_id: @api_user.avatar_id, avatar_size: @api_user.avatar_size, confirmation_sent_at: @api_user.confirmation_sent_at, confirmation_token: @api_user.confirmation_token, confirmed_at: @api_user.confirmed_at, created_at: @api_user.created_at, email: @api_user.email, last_seen_at: @api_user.last_seen_at, locale: @api_user.locale, name: @api_user.name, reset_password_sent_at: @api_user.reset_password_sent_at, reset_password_token: @api_user.reset_password_token, role_id: @api_user.role_id, time_zone: @api_user.time_zone, updated_at: @api_user.updated_at }
    end

    assert_redirected_to api_user_path(assigns(:api_user))
  end

  test "should show api_user" do
    get :show, id: @api_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_user
    assert_response :success
  end

  test "should update api_user" do
    patch :update, id: @api_user, api_user: { avatar_content_type: @api_user.avatar_content_type, avatar_filename: @api_user.avatar_filename, avatar_id: @api_user.avatar_id, avatar_size: @api_user.avatar_size, confirmation_sent_at: @api_user.confirmation_sent_at, confirmation_token: @api_user.confirmation_token, confirmed_at: @api_user.confirmed_at, created_at: @api_user.created_at, email: @api_user.email, last_seen_at: @api_user.last_seen_at, locale: @api_user.locale, name: @api_user.name, reset_password_sent_at: @api_user.reset_password_sent_at, reset_password_token: @api_user.reset_password_token, role_id: @api_user.role_id, time_zone: @api_user.time_zone, updated_at: @api_user.updated_at }
    assert_redirected_to api_user_path(assigns(:api_user))
  end

  test "should destroy api_user" do
    assert_difference('ApiUser.count', -1) do
      delete :destroy, id: @api_user
    end

    assert_redirected_to api_users_path
  end
end
