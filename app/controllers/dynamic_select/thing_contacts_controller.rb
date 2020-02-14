module DynamicSelect
  class ThingContactsController < ApplicationController
    respond_to :json
    skip_authorization_check
    def index
      @thing_contacts = Thing.find(params[:thing_id]).thing_contacts.select(:name, :id)
      respond_with(@thing_contacts)
    end
  end
end