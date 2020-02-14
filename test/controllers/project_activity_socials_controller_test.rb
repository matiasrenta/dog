require 'test_helper'

class ProjectActivitySocialsControllerTest < ActionController::TestCase
  setup do
    @project_activity_social = project_activity_socials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_activity_socials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_activity_social" do
    assert_difference('ProjectActivitySocial.count') do
      post :create, project_activity_social: { comentarios: @project_activity_social.comentarios, fecha_fin_real: @project_activity_social.fecha_fin_real, fecha_inicio_real: @project_activity_social.fecha_inicio_real, nro_beneficiarios: @project_activity_social.nro_beneficiarios, nro_metas_cumplidas: @project_activity_social.nro_metas_cumplidas, project_social_id: @project_activity_social.project_social_id, social_development_program_id: @project_activity_social.social_development_program_id }
    end

    assert_redirected_to project_activity_social_path(assigns(:project_activity_social))
  end

  test "should show project_activity_social" do
    get :show, id: @project_activity_social
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_activity_social
    assert_response :success
  end

  test "should update project_activity_social" do
    patch :update, id: @project_activity_social, project_activity_social: { comentarios: @project_activity_social.comentarios, fecha_fin_real: @project_activity_social.fecha_fin_real, fecha_inicio_real: @project_activity_social.fecha_inicio_real, nro_beneficiarios: @project_activity_social.nro_beneficiarios, nro_metas_cumplidas: @project_activity_social.nro_metas_cumplidas, project_social_id: @project_activity_social.project_social_id, social_development_program_id: @project_activity_social.social_development_program_id }
    assert_redirected_to project_activity_social_path(assigns(:project_activity_social))
  end

  test "should destroy project_activity_social" do
    assert_difference('ProjectActivitySocial.count', -1) do
      delete :destroy, id: @project_activity_social
    end

    assert_redirected_to project_activity_socials_path
  end
end
