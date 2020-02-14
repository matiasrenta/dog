require 'test_helper'

class ProjectActivityObrasControllerTest < ActionController::TestCase
  setup do
    @project_activity_obra = project_activity_obras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_activity_obras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_activity_obra" do
    assert_difference('ProjectActivityObra.count') do
      post :create, project_activity_obra: { avance_programado: @project_activity_obra.avance_programado, avance_real: @project_activity_obra.avance_real, calle: @project_activity_obra.calle, cantidad: @project_activity_obra.cantidad, codigo_postal: @project_activity_obra.codigo_postal, colonia: @project_activity_obra.colonia, description: @project_activity_obra.description, name: @project_activity_obra.name, nro_exterior: @project_activity_obra.nro_exterior, nro_interior: @project_activity_obra.nro_interior, project_obra_id: @project_activity_obra.project_obra_id, real_end_date: @project_activity_obra.real_end_date, real_start_date: @project_activity_obra.real_start_date, tipo_obra: @project_activity_obra.tipo_obra }
    end

    assert_redirected_to project_activity_obra_path(assigns(:project_activity_obra))
  end

  test "should show project_activity_obra" do
    get :show, id: @project_activity_obra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_activity_obra
    assert_response :success
  end

  test "should update project_activity_obra" do
    patch :update, id: @project_activity_obra, project_activity_obra: { avance_programado: @project_activity_obra.avance_programado, avance_real: @project_activity_obra.avance_real, calle: @project_activity_obra.calle, cantidad: @project_activity_obra.cantidad, codigo_postal: @project_activity_obra.codigo_postal, colonia: @project_activity_obra.colonia, description: @project_activity_obra.description, name: @project_activity_obra.name, nro_exterior: @project_activity_obra.nro_exterior, nro_interior: @project_activity_obra.nro_interior, project_obra_id: @project_activity_obra.project_obra_id, real_end_date: @project_activity_obra.real_end_date, real_start_date: @project_activity_obra.real_start_date, tipo_obra: @project_activity_obra.tipo_obra }
    assert_redirected_to project_activity_obra_path(assigns(:project_activity_obra))
  end

  test "should destroy project_activity_obra" do
    assert_difference('ProjectActivityObra.count', -1) do
      delete :destroy, id: @project_activity_obra
    end

    assert_redirected_to project_activity_obras_path
  end
end
