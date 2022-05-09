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

    def route_not_found
        render json: { errors: "route not found" }, status: :not_found
    end

    def return_valid_fail_json(obj)
        render json: { errors: obj.errors.objects.first.full_message }, status: 422
    end
end
