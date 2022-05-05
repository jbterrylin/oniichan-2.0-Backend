class UserShopsController < ApplicationController
    before_action :authorize_request
    before_action :set_user_shop, only: %i[ show edit update destroy ]

    def index
        render json: { status: :ok, data: UserShop.all }
    end
  
    def show
        userShop = UserShop.where(user_id: get_user_id)
        lastCreateDate = userShop.maximum(:created_at)
        render json: { status: :ok, data: userShop.where(created_at: lastCreateDate)[0] }
    end

    def create
        user = UserShop.create(object_with_user_id(user_shop_params))
        render json: { status: :ok, data: user, showToast: { message: "成功", color: "primary", timer: 2000, icon: "mdi" } }
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_shop
        @shop = UserShop.find_by(id: get_user_id)
    end

    # Only allow a list of trusted parameters through.
    def user_shop_params
        params.permit(:name, :address, :ssm, :boss_name, :boss_phone, :nick_name)
    end
end
