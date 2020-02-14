require 'test_helper'

class ProjectActivityAdquisicionsControllerTest < ActionController::TestCase
  setup do
    @project_activity_adquisicion = project_activity_adquisicions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_activity_adquisicions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_activity_adquisicion" do
    assert_difference('ProjectActivityAdquisicion.count') do
      post :create, project_activity_adquisicion: { avance_programado: @project_activity_adquisicion.avance_programado, avance_real: @project_activity_adquisicion.avance_real, calle: @project_activity_adquisicion.calle, cantidad: @project_activity_adquisicion.cantidad, codigo_postal: @project_activity_adquisicion.codigo_postal, colonia: @project_activity_adquisicion.colonia, description: @project_activity_adquisicion.description, name: @project_activity_adquisicion.name, nro_exterior: @project_activity_adquisicion.nro_exterior, nro_interior: @project_activity_adquisicion.nro_interior, project_adquisicion_id: @project_activity_adquisicion.project_adquisicion_id, real_end_date: @project_activity_adquisicion.real_end_date, real_start_date: @project_activity_adquisicion.real_start_date, tipo_adquisicion: @project_activity_adquisicion.tipo_adquisicion }
    end

    assert_redirected_to project_activity_adquisicion_path(assigns(:project_activity_adquisicion))
  end

  test "should show project_activity_adquisicion" do
    get :show, id: @project_activity_adquisicion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_activity_adquisicion
    assert_response :success
  end

  test "should update project_activity_adquisicion" do
    patch :update, id: @project_activity_adquisicion, project_activity_adquisicion: { avance_programado: @project_activity_adquisicion.avance_programado, avance_real: @project_activity_adquisicion.avance_real, calle: @project_activity_adquisicion.calle, cantidad: @project_activity_adquisicion.cantidad, codigo_postal: @project_activity_adquisicion.codigo_postal, colonia: @project_activity_adquisicion.colonia, description: @project_activity_adquisicion.description, name: @project_activity_adquisicion.name, nro_exterior: @project_activity_adquisicion.nro_exterior, nro_interior: @project_activity_adquisicion.nro_interior, project_adquisicion_id: @project_activity_adquisicion.project_adquisicion_id, real_end_date: @project_activity_adquisicion.real_end_date, real_start_date: @project_activity_adquisicion.real_start_date, tipo_adquisicion: @project_activity_adquisicion.tipo_adquisicion }
    assert_redirected_to project_activity_adquisicion_path(assigns(:project_activity_adquisicion))
  end

  test "should destroy project_activity_adquisicion" do
    assert_difference('ProjectActivityAdquisicion.count', -1) do
      delete :destroy, id: @project_activity_adquisicion
    end

    assert_redirected_to project_activity_adquisicions_path
  end
end
