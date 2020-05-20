module DynamicSelect
  class ProductBoxesController < ApplicationController
    respond_to :json
    skip_authorization_check
    def index
      @boxes = Product.find(params[:product_id]).boxes.select(:name, :id)
      respond_with(@boxes)
    end
  end
end