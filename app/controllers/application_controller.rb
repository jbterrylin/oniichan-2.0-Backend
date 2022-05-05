class ApplicationController < ActionController::Base
    
    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    def get_user_id
        return JsonWebToken.decode(request.headers['Authorization'].split(' ').last)[:user_id]
    end

    def object_with_user_id(obj)
        return obj.merge(:user_id => get_user_id)
    end

    def route_not_found
        render json: { message: "route not found" }, status: :not_found
    end
end
