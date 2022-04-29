class ApplicationController < ActionController::Base
    before_action :require_login

    def require_login
        redirect_to login_index_path unless session.include? :user_id
    end

    def current_user
        return User.find(session[:user_id]) if session[:user_id]
    end
end
