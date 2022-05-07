module UserShopsHelper
    def current_User_Shop
        userShop = UserShop.where(users_id: get_user_id)
        lastCreateDate = userShop.maximum(:created_at)
        return userShop.where(created_at: lastCreateDate)[0]
    end
end
