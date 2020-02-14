require 'test_helper'

class BeneficiariesControllerTest < ActionController::TestCase
  setup do
    @beneficiary = beneficiaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beneficiaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beneficiary" do
    assert_difference('Beneficiary.count') do
      post :create, beneficiary: { anios_residencia_en_df: @beneficiary.anios_residencia_en_df, apellido_materno: @beneficiary.apellido_materno, apellido_paterno: @beneficiary.apellido_paterno, curp: @beneficiary.curp, domicilio: @beneficiary.domicilio, edad: @beneficiary.edad, fecha_nacimiento: @beneficiary.fecha_nacimiento, grado_maximo_estudios: @beneficiary.grado_maximo_estudios, lugar_nacimiento: @beneficiary.lugar_nacimiento, nombre_madre: @beneficiary.nombre_madre, nombre_padre: @beneficiary.nombre_padre, nombres: @beneficiary.nombres, ocupacion: @beneficiary.ocupacion, pertenencia_etnica: @beneficiary.pertenencia_etnica, sexo: @beneficiary.sexo, territorial_unit_id: @beneficiary.territorial_unit_id }
    end

    assert_redirected_to beneficiary_path(assigns(:beneficiary))
  end

  test "should show beneficiary" do
    get :show, id: @beneficiary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beneficiary
    assert_response :success
  end

  test "should update beneficiary" do
    patch :update, id: @beneficiary, beneficiary: { anios_residencia_en_df: @beneficiary.anios_residencia_en_df, apellido_materno: @beneficiary.apellido_materno, apellido_paterno: @beneficiary.apellido_paterno, curp: @beneficiary.curp, domicilio: @beneficiary.domicilio, edad: @beneficiary.edad, fecha_nacimiento: @beneficiary.fecha_nacimiento, grado_maximo_estudios: @beneficiary.grado_maximo_estudios, lugar_nacimiento: @beneficiary.lugar_nacimiento, nombre_madre: @beneficiary.nombre_madre, nombre_padre: @beneficiary.nombre_padre, nombres: @beneficiary.nombres, ocupacion: @beneficiary.ocupacion, pertenencia_etnica: @beneficiary.pertenencia_etnica, sexo: @beneficiary.sexo, territorial_unit_id: @beneficiary.territorial_unit_id }
    assert_redirected_to beneficiary_path(assigns(:beneficiary))
  end

  test "should destroy beneficiary" do
    assert_difference('Beneficiary.count', -1) do
      delete :destroy, id: @beneficiary
    end

    assert_redirected_to beneficiaries_path
  end
end
