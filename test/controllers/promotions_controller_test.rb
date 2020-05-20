require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  setup do
    @promotion = promotions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promotions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promotion" do
    assert_difference('Promotion.count') do
      post :create, promotion: { box_id: @promotion.box_id, end_with: @promotion.end_with, expiration_date: @promotion.expiration_date, from_date: @promotion.from_date, name: @promotion.name, notes: @promotion.notes, product_id: @promotion.product_id, promo_type: @promotion.promo_type, quantity_available: @promotion.quantity_available, quantity_start: @promotion.quantity_start, to_date: @promotion.to_date }
    end

    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should show promotion" do
    get :show, id: @promotion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promotion
    assert_response :success
  end

  test "should update promotion" do
    patch :update, id: @promotion, promotion: { box_id: @promotion.box_id, end_with: @promotion.end_with, expiration_date: @promotion.expiration_date, from_date: @promotion.from_date, name: @promotion.name, notes: @promotion.notes, product_id: @promotion.product_id, promo_type: @promotion.promo_type, quantity_available: @promotion.quantity_available, quantity_start: @promotion.quantity_start, to_date: @promotion.to_date }
    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should destroy promotion" do
    assert_difference('Promotion.count', -1) do
      delete :destroy, id: @promotion
    end

    assert_redirected_to promotions_path
  end
end
