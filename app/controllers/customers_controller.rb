class CustomersController < ApplicationController
    before_action :authorize_request

    def index
        customer = Customer.all
        render json: { status: :ok, data: customer }
    end
end
