class Paper < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    has_one :customer, class_name: "Customer", foreign_key: "paper_id"
    has_one :user_shop, class_name: "UserShop", foreign_key: "user_shop_id"
    has_many :items, class_name: "Item", foreign_key: "paper_id"

    accepts_nested_attributes_for :customer, :items
end
