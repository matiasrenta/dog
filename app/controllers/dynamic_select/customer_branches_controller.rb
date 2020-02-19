module DynamicSelect
  class CustomerBranchesController < ApplicationController
    respond_to :json
    skip_authorization_check
    def index
      @customer_branches = Customer.find(params[:customer_id]).customer_branches.select(:name, :id)
      respond_with(@customer_branches)
    end
  end
end