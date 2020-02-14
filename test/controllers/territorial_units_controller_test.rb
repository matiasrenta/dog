require 'test_helper'

class TerritorialUnitsControllerTest < ActionController::TestCase
  setup do
    @territorial_unit = territorial_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:territorial_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create territorial_unit" do
    assert_difference('TerritorialUnit.count') do
      post :create, territorial_unit: { code: @territorial_unit.code, grado_marginacion: @territorial_unit.grado_marginacion, name: @territorial_unit.name }
    end

    assert_redirected_to territorial_unit_path(assigns(:territorial_unit))
  end

  test "should show territorial_unit" do
    get :show, id: @territorial_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @territorial_unit
    assert_response :success
  end

  test "should update territorial_unit" do
    patch :update, id: @territorial_unit, territorial_unit: { code: @territorial_unit.code, grado_marginacion: @territorial_unit.grado_marginacion, name: @territorial_unit.name }
    assert_redirected_to territorial_unit_path(assigns(:territorial_unit))
  end

  test "should destroy territorial_unit" do
    assert_difference('TerritorialUnit.count', -1) do
      delete :destroy, id: @territorial_unit
    end

    assert_redirected_to territorial_units_path
  end
end
