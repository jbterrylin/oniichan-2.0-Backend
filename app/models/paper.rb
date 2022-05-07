class Paper < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    has_one :customer, class_name: "Customer", foreign_key: "papers_id"
    has_one :user_shop, class_name: "UserShop", foreign_key: "user_shops_id"
    has_many :items, class_name: "Item", foreign_key: "papers_id"

    accepts_nested_attributes_for :customer, :items

    validates :name, presence: true
    validates :paper_type, presence: true, inclusion: { in: %w(quotation receipt), message: "%{value} is not a valid paper type" }
    validates :price_unit, presence: true, inclusion: { in: %w(rm sgd), message: "%{value} is not a valid paper type" }
    validates :discount, presence: true
    validates :deposit, presence: true
    validates :is_deleted, presence: false
    # validates :customers_id, presence: true
    # validates :user_shops_id, presence: true
    validates :users_id, presence: true
end
