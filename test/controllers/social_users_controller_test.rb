require 'test_helper'

class SocialUsersControllerTest < ActionController::TestCase
  setup do
    @social_user = social_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:social_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create social_user" do
    assert_difference('SocialUser.count') do
      post :create, social_user: { access_token: @social_user.access_token, email: @social_user.email, json_data: @social_user.json_data, provider: @social_user.provider, uid: @social_user.uid }
    end

    assert_redirected_to social_user_path(assigns(:social_user))
  end

  test "should show social_user" do
    get :show, id: @social_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @social_user
    assert_response :success
  end

  test "should update social_user" do
    patch :update, id: @social_user, social_user: { access_token: @social_user.access_token, email: @social_user.email, json_data: @social_user.json_data, provider: @social_user.provider, uid: @social_user.uid }
    assert_redirected_to social_user_path(assigns(:social_user))
  end

  test "should destroy social_user" do
    assert_difference('SocialUser.count', -1) do
      delete :destroy, id: @social_user
    end

    assert_redirected_to social_users_path
  end
end
