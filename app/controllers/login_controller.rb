class LoginController < ApplicationController
    before_action :authorize_request, except: :create

    def create
        # @hashpassword = 
        user = User.find_by(name: params[:name], password: params[:password])
        if user
            token = JsonWebToken.encode(user_id: user.id)
            time = Time.now + 24.hours.to_i

            render json: { status: :ok, message: 'Success', token: token, exp: time.strftime("%m-%d-%Y %H:%M"), data: user.as_json.except("password") }
        else
            render json: { message: "wrong password or name" }, status: 404
        end
    end
end
