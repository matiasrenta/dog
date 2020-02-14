require 'test_helper'

class CatUniMeasureUnitsControllerTest < ActionController::TestCase
  setup do
    @cat_uni_measure_unit = cat_uni_measure_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_uni_measure_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_uni_measure_unit" do
    assert_difference('CatUniMeasureUnit.count') do
      post :create, cat_uni_measure_unit: { description: @cat_uni_measure_unit.description, key: @cat_uni_measure_unit.key }
    end

    assert_redirected_to cat_uni_measure_unit_path(assigns(:cat_uni_measure_unit))
  end

  test "should show cat_uni_measure_unit" do
    get :show, id: @cat_uni_measure_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_uni_measure_unit
    assert_response :success
  end

  test "should update cat_uni_measure_unit" do
    patch :update, id: @cat_uni_measure_unit, cat_uni_measure_unit: { description: @cat_uni_measure_unit.description, key: @cat_uni_measure_unit.key }
    assert_redirected_to cat_uni_measure_unit_path(assigns(:cat_uni_measure_unit))
  end

  test "should destroy cat_uni_measure_unit" do
    assert_difference('CatUniMeasureUnit.count', -1) do
      delete :destroy, id: @cat_uni_measure_unit
    end

    assert_redirected_to cat_uni_measure_units_path
  end
end
