require 'test_helper'

class CatPprParChaptersControllerTest < ActionController::TestCase
  setup do
    @cat_ppr_par_chapter = cat_ppr_par_chapters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ppr_par_chapters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ppr_par_chapter" do
    assert_difference('CatPprParChapter.count') do
      post :create, cat_ppr_par_chapter: { description: @cat_ppr_par_chapter.description, key: @cat_ppr_par_chapter.key }
    end

    assert_redirected_to cat_ppr_par_chapter_path(assigns(:cat_ppr_par_chapter))
  end

  test "should show cat_ppr_par_chapter" do
    get :show, id: @cat_ppr_par_chapter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ppr_par_chapter
    assert_response :success
  end

  test "should update cat_ppr_par_chapter" do
    patch :update, id: @cat_ppr_par_chapter, cat_ppr_par_chapter: { description: @cat_ppr_par_chapter.description, key: @cat_ppr_par_chapter.key }
    assert_redirected_to cat_ppr_par_chapter_path(assigns(:cat_ppr_par_chapter))
  end

  test "should destroy cat_ppr_par_chapter" do
    assert_difference('CatPprParChapter.count', -1) do
      delete :destroy, id: @cat_ppr_par_chapter
    end

    assert_redirected_to cat_ppr_par_chapters_path
  end
end
