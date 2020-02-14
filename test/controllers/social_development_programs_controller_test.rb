require 'test_helper'

class SocialDevelopmentProgramsControllerTest < ActionController::TestCase
  setup do
    @social_development_program = social_development_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:social_development_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create social_development_program" do
    assert_difference('SocialDevelopmentProgram.count') do
      post :create, social_development_program: { name: @social_development_program.name }
    end

    assert_redirected_to social_development_program_path(assigns(:social_development_program))
  end

  test "should show social_development_program" do
    get :show, id: @social_development_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @social_development_program
    assert_response :success
  end

  test "should update social_development_program" do
    patch :update, id: @social_development_program, social_development_program: { name: @social_development_program.name }
    assert_redirected_to social_development_program_path(assigns(:social_development_program))
  end

  test "should destroy social_development_program" do
    assert_difference('SocialDevelopmentProgram.count', -1) do
      delete :destroy, id: @social_development_program
    end

    assert_redirected_to social_development_programs_path
  end
end
