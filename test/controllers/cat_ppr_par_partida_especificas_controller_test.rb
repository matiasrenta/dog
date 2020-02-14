require 'test_helper'

class CatPprParPartidaEspecificasControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_par_partida_especifica = cat_ppr_par_partida_especificas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_par_partida_especificas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_par_partida_especifica" do
    assert_difference('CatPprParPartidaEspecifica.count') do
      post :create, cat_ppr_par_partida_especifica: { cat_ppr_par_partida_generica_id: @cat_ppr_par_partida_especifica.cat_ppr_par_partida_generica_id, description: @cat_ppr_par_partida_especifica.description, key: @cat_ppr_par_partida_especifica.key }
    end

    assert_redirected_to cat_ppr_par_partida_especifica_path(assigns(:cat_ppr_par_partida_especifica))
  end

  test "should show cat_ppr_par_partida_especifica" do
    get :show, id: @cat_ppr_par_partida_especifica
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_par_partida_especifica
    assert_response :success
  end

  test "should update cat_ppr_par_partida_especifica" do
    patch :update, id: @cat_ppr_par_partida_especifica, cat_ppr_par_partida_especifica: { cat_ppr_par_partida_generica_id: @cat_ppr_par_partida_especifica.cat_ppr_par_partida_generica_id, description: @cat_ppr_par_partida_especifica.description, key: @cat_ppr_par_partida_especifica.key }
    assert_redirected_to cat_ppr_par_partida_especifica_path(assigns(:cat_ppr_par_partida_especifica))
  end

  test "should destroy cat_ppr_par_partida_especifica" do
    assert_difference('CatPprParPartidaEspecifica.count', -1) do
      delete :destroy, id: @cat_ppr_par_partida_especifica
    end

    assert_redirected_to cat_ppr_par_partida_especificas_path
  end
end
