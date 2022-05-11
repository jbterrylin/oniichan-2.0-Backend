class UserShopsController < ApplicationController
    before_action :authorize_request

    def index
        render json: { status: :ok, data: UserShop.all }
    end
  
    def show
        render json: { status: :ok, data: helpers.current_User_Shop }
    end

    def create
        userShop = UserShop.where(users_id: helpers.get_user_id)
        
        # only check if have record
        if !helpers.current_User_Shop.nil?
            userShop = helpers.current_User_Shop.as_json.keep_if {|k, v| ["name", "address", "ssm", "boss_name", "boss_phone", "nick_name", "comment"].include?(k)}

            if user_shop_params == userShop
                render json: { errors: "Don't update shop with same data" }, status: 422
                return
            end
        end

        shop = UserShop.new(helpers.object_with_user_id(user_shop_params))

        if  shop.valid? & shop.save
            render json: { status: :ok, data: shop, showToast: { message: "成功", color: "primary", timer: 2000, icon: "mdi" } }
        else
            return_valid_fail_json(shop)
        end
    end

    private
    # Only allow a list of trusted parameters through.
    def user_shop_params
        params.permit(:name, :address, :ssm, :boss_name, :boss_phone, :nick_name, :comment)
    end
end
