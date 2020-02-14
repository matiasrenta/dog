require 'test_helper'

class CatPprParConceptsControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_par_concept = cat_ppr_par_concepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_par_concepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_par_concept" do
    assert_difference('CatPprParConcept.count') do
      post :create, cat_ppr_par_concept: { cat_ppr_par_chapter_id: @cat_ppr_par_concept.cat_ppr_par_chapter_id, description: @cat_ppr_par_concept.description, key: @cat_ppr_par_concept.key }
    end

    assert_redirected_to cat_ppr_par_concept_path(assigns(:cat_ppr_par_concept))
  end

  test "should show cat_ppr_par_concept" do
    get :show, id: @cat_ppr_par_concept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_par_concept
    assert_response :success
  end

  test "should update cat_ppr_par_concept" do
    patch :update, id: @cat_ppr_par_concept, cat_ppr_par_concept: { cat_ppr_par_chapter_id: @cat_ppr_par_concept.cat_ppr_par_chapter_id, description: @cat_ppr_par_concept.description, key: @cat_ppr_par_concept.key }
    assert_redirected_to cat_ppr_par_concept_path(assigns(:cat_ppr_par_concept))
  end

  test "should destroy cat_ppr_par_concept" do
    assert_difference('CatPprParConcept.count', -1) do
      delete :destroy, id: @cat_ppr_par_concept
    end

    assert_redirected_to cat_ppr_par_concepts_path
  end
end
