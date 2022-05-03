class LoginController < ApplicationController
    skip_before_action :require_login, only: [:create]

  def create
    if params[:isLogin]
        # @hashpassword = 
        user = User.find_by(name: params[:name], password: params[:password])
        if user
            session[:user_id] = user.id

            render json: { status: :ok, message: 'Success', data: user.as_json.except("password") }
        else
            render json: { message: "data not found" }, status: 404
        end
    else
        user = User.new(user_params)
        user.as_json.except("password")
        if user.save
            render json: { status: :ok, message: 'Success' }
        else
            render json: { json: user.errors, status: :unprocessable_entity }
        end
    end
  end
end
