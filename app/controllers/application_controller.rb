class ApplicationController < ActionController::Base
    before_action :require_login, :except=>[:route_not_found]

    def require_login
        render json: {}, status: 401 unless session.include? :user_id
    end

    def current_user
        return User.find(session[:user_id]) if session[:user_id]
    end

    def route_not_found
        render json: { message: "route not found" }, status: :not_found
    end
end
