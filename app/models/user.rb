class User < ApplicationRecord
    has_many :customers, class_name: "customer", foreign_key: "user_id"
    has_many :items, class_name: "item", foreign_key: "user_id"
    has_many :papers, class_name: "paper", foreign_key: "user_id"
end
