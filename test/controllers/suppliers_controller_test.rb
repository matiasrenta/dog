require 'test_helper'

class SuppliersControllerTest < ActionController::TestCase
  setup do
    @supplier = suppliers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suppliers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier" do
    assert_difference('Supplier.count') do
      post :create, supplier: { calle: @supplier.calle, codigo_postal: @supplier.codigo_postal, entre_calles: @supplier.entre_calles, name: @supplier.name, nro_exterior: @supplier.nro_exterior, nro_interior: @supplier.nro_interior, observaciones: @supplier.observaciones, razon_social: @supplier.razon_social, rfc: @supplier.rfc, state_id: @supplier.state_id, town_id: @supplier.town_id }
    end

    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should show supplier" do
    get :show, id: @supplier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier
    assert_response :success
  end

  test "should update supplier" do
    patch :update, id: @supplier, supplier: { calle: @supplier.calle, codigo_postal: @supplier.codigo_postal, entre_calles: @supplier.entre_calles, name: @supplier.name, nro_exterior: @supplier.nro_exterior, nro_interior: @supplier.nro_interior, observaciones: @supplier.observaciones, razon_social: @supplier.razon_social, rfc: @supplier.rfc, state_id: @supplier.state_id, town_id: @supplier.town_id }
    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should destroy supplier" do
    assert_difference('Supplier.count', -1) do
      delete :destroy, id: @supplier
    end

    assert_redirected_to suppliers_path
  end
end
