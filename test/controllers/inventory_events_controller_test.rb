require 'test_helper'

class InventoryEventsControllerTest < ActionController::TestCase
  setup do
    @inventory_event = inventory_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_event" do
    assert_difference('InventoryEvent.count') do
      post :create, inventory_event: { box_id: @inventory_event.box_id, entity_id: @inventory_event.entity_id, entity_serialized: @inventory_event.entity_serialized, entity_type: @inventory_event.entity_type, event: @inventory_event.event, inventory_id: @inventory_event.inventory_id, notes: @inventory_event.notes, quantity: @inventory_event.quantity, reason: @inventory_event.reason }
    end

    assert_redirected_to inventory_event_path(assigns(:inventory_event))
  end

  test "should show inventory_event" do
    get :show, id: @inventory_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_event
    assert_response :success
  end

  test "should update inventory_event" do
    patch :update, id: @inventory_event, inventory_event: { box_id: @inventory_event.box_id, entity_id: @inventory_event.entity_id, entity_serialized: @inventory_event.entity_serialized, entity_type: @inventory_event.entity_type, event: @inventory_event.event, inventory_id: @inventory_event.inventory_id, notes: @inventory_event.notes, quantity: @inventory_event.quantity, reason: @inventory_event.reason }
    assert_redirected_to inventory_event_path(assigns(:inventory_event))
  end

  test "should destroy inventory_event" do
    assert_difference('InventoryEvent.count', -1) do
      delete :destroy, id: @inventory_event
    end

    assert_redirected_to inventory_events_path
  end
end
