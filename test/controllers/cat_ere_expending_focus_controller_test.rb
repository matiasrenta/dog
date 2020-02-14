require 'test_helper'

class CatEreExpendingFocusControllerTest < ActionController::TestCase
  setup do
    @cat_ere_expending_focu = cat_ere_expending_focus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_ere_expending_focus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_ere_expending_focu" do
    assert_difference('CatEreExpendingFocu.count') do
      post :create, cat_ere_expending_focu: { description: @cat_ere_expending_focu.description, key: @cat_ere_expending_focu.key }
    end

    assert_redirected_to cat_ere_expending_focu_path(assigns(:cat_ere_expending_focu))
  end

  test "should show cat_ere_expending_focu" do
    get :show, id: @cat_ere_expending_focu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_ere_expending_focu
    assert_response :success
  end

  test "should update cat_ere_expending_focu" do
    patch :update, id: @cat_ere_expending_focu, cat_ere_expending_focu: { description: @cat_ere_expending_focu.description, key: @cat_ere_expending_focu.key }
    assert_redirected_to cat_ere_expending_focu_path(assigns(:cat_ere_expending_focu))
  end

  test "should destroy cat_ere_expending_focu" do
    assert_difference('CatEreExpendingFocu.count', -1) do
      delete :destroy, id: @cat_ere_expending_focu
    end

    assert_redirected_to cat_ere_expending_focus_path
  end
end
