require 'test_helper'

class LeyFraccionsControllerTest < ActionController::TestCase
  setup do
    @ley_fraccion = ley_fraccions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ley_fraccions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ley_fraccion" do
    assert_difference('LeyFraccion.count') do
      post :create, ley_fraccion: { actualizado: @ley_fraccion.actualizado, codigo: @ley_fraccion.codigo, descripcion_de_documento: @ley_fraccion.descripcion_de_documento, detalle: @ley_fraccion.detalle, file_content_type: @ley_fraccion.file_content_type, file_filename: @ley_fraccion.file_filename, file_id: @ley_fraccion.file_id, file_size: @ley_fraccion.file_size, ley_articulo_id: @ley_fraccion.ley_articulo_id, name: @ley_fraccion.name, periodo_actualizacion: @ley_fraccion.periodo_actualizacion, validado: @ley_fraccion.validado }
    end

    assert_redirected_to ley_fraccion_path(assigns(:ley_fraccion))
  end

  test "should show ley_fraccion" do
    get :show, id: @ley_fraccion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ley_fraccion
    assert_response :success
  end

  test "should update ley_fraccion" do
    patch :update, id: @ley_fraccion, ley_fraccion: { actualizado: @ley_fraccion.actualizado, codigo: @ley_fraccion.codigo, descripcion_de_documento: @ley_fraccion.descripcion_de_documento, detalle: @ley_fraccion.detalle, file_content_type: @ley_fraccion.file_content_type, file_filename: @ley_fraccion.file_filename, file_id: @ley_fraccion.file_id, file_size: @ley_fraccion.file_size, ley_articulo_id: @ley_fraccion.ley_articulo_id, name: @ley_fraccion.name, periodo_actualizacion: @ley_fraccion.periodo_actualizacion, validado: @ley_fraccion.validado }
    assert_redirected_to ley_fraccion_path(assigns(:ley_fraccion))
  end

  test "should destroy ley_fraccion" do
    assert_difference('LeyFraccion.count', -1) do
      delete :destroy, id: @ley_fraccion
    end

    assert_redirected_to ley_fraccions_path
  end
end
