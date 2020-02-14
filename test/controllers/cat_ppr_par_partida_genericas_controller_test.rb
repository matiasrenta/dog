require 'test_helper'

class CatPprParPartidaGenericasControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_par_partida_generica = cat_ppr_par_partida_genericas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_par_partida_genericas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_par_partida_generica" do
    assert_difference('CatPprParPartidaGenerica.count') do
      post :create, cat_ppr_par_partida_generica: { cat_ppr_par_concept_id: @cat_ppr_par_partida_generica.cat_ppr_par_concept_id, description: @cat_ppr_par_partida_generica.description, key: @cat_ppr_par_partida_generica.key }
    end

    assert_redirected_to cat_ppr_par_partida_generica_path(assigns(:cat_ppr_par_partida_generica))
  end

  test "should show cat_ppr_par_partida_generica" do
    get :show, id: @cat_ppr_par_partida_generica
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_par_partida_generica
    assert_response :success
  end

  test "should update cat_ppr_par_partida_generica" do
    patch :update, id: @cat_ppr_par_partida_generica, cat_ppr_par_partida_generica: { cat_ppr_par_concept_id: @cat_ppr_par_partida_generica.cat_ppr_par_concept_id, description: @cat_ppr_par_partida_generica.description, key: @cat_ppr_par_partida_generica.key }
    assert_redirected_to cat_ppr_par_partida_generica_path(assigns(:cat_ppr_par_partida_generica))
  end

  test "should destroy cat_ppr_par_partida_generica" do
    assert_difference('CatPprParPartidaGenerica.count', -1) do
      delete :destroy, id: @cat_ppr_par_partida_generica
    end

    assert_redirected_to cat_ppr_par_partida_genericas_path
  end
end
