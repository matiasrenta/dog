require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  setup do
    @staff = staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, staff: { anios_residencia_en_df: @staff.anios_residencia_en_df, apellido_materno: @staff.apellido_materno, apellido_paterno: @staff.apellido_paterno, ascription_id: @staff.ascription_id, curp: @staff.curp, domicilio: @staff.domicilio, fecha_nacimiento: @staff.fecha_nacimiento, importe_actual: @staff.importe_actual, indefinido: @staff.indefinido, job_title_id: @staff.job_title_id, nombre_madre: @staff.nombre_madre, nombre_padre: @staff.nombre_padre, nombres: @staff.nombres, ocupacion: @staff.ocupacion, periodo_desde: @staff.periodo_desde, periodo_hasta: @staff.periodo_hasta, sexo: @staff.sexo }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, id: @staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff
    assert_response :success
  end

  test "should update staff" do
    patch :update, id: @staff, staff: { anios_residencia_en_df: @staff.anios_residencia_en_df, apellido_materno: @staff.apellido_materno, apellido_paterno: @staff.apellido_paterno, ascription_id: @staff.ascription_id, curp: @staff.curp, domicilio: @staff.domicilio, fecha_nacimiento: @staff.fecha_nacimiento, importe_actual: @staff.importe_actual, indefinido: @staff.indefinido, job_title_id: @staff.job_title_id, nombre_madre: @staff.nombre_madre, nombre_padre: @staff.nombre_padre, nombres: @staff.nombres, ocupacion: @staff.ocupacion, periodo_desde: @staff.periodo_desde, periodo_hasta: @staff.periodo_hasta, sexo: @staff.sexo }
    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should destroy staff" do
    assert_difference('Staff.count', -1) do
      delete :destroy, id: @staff
    end

    assert_redirected_to staffs_path
  end
end
