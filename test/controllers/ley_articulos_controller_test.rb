require 'test_helper'

class LeyArticulosControllerTest < ActionController::TestCase
  setup do
    @ley_articulo = ley_articulos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ley_articulos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ley_articulo" do
    assert_difference('LeyArticulo.count') do
      post :create, ley_articulo: { actualizado: @ley_articulo.actualizado, codigo: @ley_articulo.codigo, descripcion_de_documento: @ley_articulo.descripcion_de_documento, detalle: @ley_articulo.detalle, file_content_type: @ley_articulo.file_content_type, file_filename: @ley_articulo.file_filename, file_id: @ley_articulo.file_id, file_size: @ley_articulo.file_size, name: @ley_articulo.name, periodo_actualizacion: @ley_articulo.periodo_actualizacion, validado: @ley_articulo.validado }
    end

    assert_redirected_to ley_articulo_path(assigns(:ley_articulo))
  end

  test "should show ley_articulo" do
    get :show, id: @ley_articulo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ley_articulo
    assert_response :success
  end

  test "should update ley_articulo" do
    patch :update, id: @ley_articulo, ley_articulo: { actualizado: @ley_articulo.actualizado, codigo: @ley_articulo.codigo, descripcion_de_documento: @ley_articulo.descripcion_de_documento, detalle: @ley_articulo.detalle, file_content_type: @ley_articulo.file_content_type, file_filename: @ley_articulo.file_filename, file_id: @ley_articulo.file_id, file_size: @ley_articulo.file_size, name: @ley_articulo.name, periodo_actualizacion: @ley_articulo.periodo_actualizacion, validado: @ley_articulo.validado }
    assert_redirected_to ley_articulo_path(assigns(:ley_articulo))
  end

  test "should destroy ley_articulo" do
    assert_difference('LeyArticulo.count', -1) do
      delete :destroy, id: @ley_articulo
    end

    assert_redirected_to ley_articulos_path
  end
end
