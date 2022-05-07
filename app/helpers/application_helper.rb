module ApplicationHelper
    def get_user_id
        return JsonWebToken.decode(request.headers['Authorization'].split(' ').last)[:user_id]
    end

    def object_with_user_id(obj)
        return obj.merge(:users_id => get_user_id)
    end

    def get_user
        id = JsonWebToken.decode(request.headers['Authorization'].split(' ').last)[:user_id]
        return User.find(id)
    end
    
    def return_valid_fail_json(obj)
        render json: { errors: obj.errors.objects.first.full_message }, status: 422
    end
end
