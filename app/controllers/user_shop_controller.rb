class UserShopController < ApplicationController
    skip_before_action :require_login
    before_action :set_user_shop, only: %i[ show edit update destroy ]
    include ApplicationHelper

    def index
        render json: { status: :ok, data: UserShop.all }
    end
  
    def show
        userShop = UserShop.where(user_id: params[:id])
        lastCreateDate = userShop.maximum(:created_at)
        render json: { status: :ok, data: userShop.where(created_at: lastCreateDate)[0] }
    end

    def create
        user = UserShop.create(user_shop_params)
        render json: { status: :ok, data: user, showToast: { message: "成功", color: "primary", timer: 2000, icon: "mdi" } }
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_shop
        @shop = UserShop.find_by(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_shop_params
        params.permit(:user_id, :name, :address, :ssm, :boss_name, :boss_phone, :nick_name)
    end
end
