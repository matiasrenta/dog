require 'test_helper'

class OpenDataControllerTest < ActionController::TestCase
  setup do
    @open_datum = open_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create open_datum" do
    assert_difference('OpenDatum.count') do
      post :create, open_datum: { access_level: @open_datum.access_level, contact: @open_datum.contact, description: @open_datum.description, email: @open_datum.email, file_content_type: @open_datum.file_content_type, file_filename: @open_datum.file_filename, file_id: @open_datum.file_id, file_size: @open_datum.file_size, labels: @open_datum.labels, published_by: @open_datum.published_by, title: @open_datum.title }
    end

    assert_redirected_to open_datum_path(assigns(:open_datum))
  end

  test "should show open_datum" do
    get :show, id: @open_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @open_datum
    assert_response :success
  end

  test "should update open_datum" do
    patch :update, id: @open_datum, open_datum: { access_level: @open_datum.access_level, contact: @open_datum.contact, description: @open_datum.description, email: @open_datum.email, file_content_type: @open_datum.file_content_type, file_filename: @open_datum.file_filename, file_id: @open_datum.file_id, file_size: @open_datum.file_size, labels: @open_datum.labels, published_by: @open_datum.published_by, title: @open_datum.title }
    assert_redirected_to open_datum_path(assigns(:open_datum))
  end

  test "should destroy open_datum" do
    assert_difference('OpenDatum.count', -1) do
      delete :destroy, id: @open_datum
    end

    assert_redirected_to open_data_path
  end
end
