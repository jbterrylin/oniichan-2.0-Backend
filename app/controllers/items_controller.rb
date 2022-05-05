class ItemsController < ApplicationController
    before_action :authorize_request

    def index
        item = Item.all
        render json: { status: :ok, data: item }
    end
end
