module DynamicSelect
  class InventoryReasonsController < ApplicationController
    respond_to :json
    skip_authorization_check
    def index
      case
        when params[:event_id] == InventoryEvent::EVENT_ADD
          @inventory_reasons = InventoryEvent::ADD_REASONS_COLLECTION.map {|r| {name: r[0], id: r[1]}}

        when params[:event_id] == InventoryEvent::EVENT_REMOVE
          @inventory_reasons = InventoryEvent::REMOVE_REASONS_COLLECTION.map {|r| {name: r[0], id: r[1]}}

        when params[:event_id] == InventoryEvent::EVENT_ADJUST
          @inventory_reasons = InventoryEvent::ADJUST_REASONS_COLLECTION.map {|r| {name: r[0], id: r[1]}}

        when params[:event_id] == InventoryEvent::EVENT_CONVERT
          @inventory_reasons = InventoryEvent::CONVERT_REASONS_COLLECTION.map {|r| {name: r[0], id: r[1]}}

        else
          raise('Unknown invetory event')
      end

      respond_with(@inventory_reasons)
    end
  end
end