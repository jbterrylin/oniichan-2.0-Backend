class UserShop < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    
    validates :name, presence: true
    validates :address, presence: true
    validates :ssm, presence: true
    validates :boss_name, presence: true
    validates :boss_phone, presence: true
    validates :nick_name, presence: true
    validates :users_id, presence: true
    validates :comment, presence: false
end
