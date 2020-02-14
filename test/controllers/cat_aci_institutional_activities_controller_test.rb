require 'test_helper'

class CatAciInstitutionalActivitiesControllerTest < ActionController::TestCase
  setup do
    @cat_aci_institutional_activity = cat_aci_institutional_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cat_aci_institutional_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cat_aci_institutional_activity" do
    assert_difference('CatAciInstitutionalActivity.count') do
      post :create, cat_aci_institutional_activity: { cat_cfu_finality_id: @cat_aci_institutional_activity.cat_cfu_finality_id, cat_cfu_function_id: @cat_aci_institutional_activity.cat_cfu_function_id, cat_cfu_subfunction_id: @cat_aci_institutional_activity.cat_cfu_subfunction_id, cat_ere_expending_focu_id: @cat_aci_institutional_activity.cat_ere_expending_focu_id, cat_ere_result_id: @cat_aci_institutional_activity.cat_ere_result_id, cat_ere_subresult_id: @cat_aci_institutional_activity.cat_ere_subresult_id, cat_pgd_axi_id: @cat_aci_institutional_activity.cat_pgd_axi_id, description: @cat_aci_institutional_activity.description, key: @cat_aci_institutional_activity.key }
    end

    assert_redirected_to cat_aci_institutional_activity_path(assigns(:cat_aci_institutional_activity))
  end

  test "should show cat_aci_institutional_activity" do
    get :show, id: @cat_aci_institutional_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cat_aci_institutional_activity
    assert_response :success
  end

  test "should update cat_aci_institutional_activity" do
    patch :update, id: @cat_aci_institutional_activity, cat_aci_institutional_activity: { cat_cfu_finality_id: @cat_aci_institutional_activity.cat_cfu_finality_id, cat_cfu_function_id: @cat_aci_institutional_activity.cat_cfu_function_id, cat_cfu_subfunction_id: @cat_aci_institutional_activity.cat_cfu_subfunction_id, cat_ere_expending_focu_id: @cat_aci_institutional_activity.cat_ere_expending_focu_id, cat_ere_result_id: @cat_aci_institutional_activity.cat_ere_result_id, cat_ere_subresult_id: @cat_aci_institutional_activity.cat_ere_subresult_id, cat_pgd_axi_id: @cat_aci_institutional_activity.cat_pgd_axi_id, description: @cat_aci_institutional_activity.description, key: @cat_aci_institutional_activity.key }
    assert_redirected_to cat_aci_institutional_activity_path(assigns(:cat_aci_institutional_activity))
  end

  test "should destroy cat_aci_institutional_activity" do
    assert_difference('CatAciInstitutionalActivity.count', -1) do
      delete :destroy, id: @cat_aci_institutional_activity
    end

    assert_redirected_to cat_aci_institutional_activities_path
  end
end
