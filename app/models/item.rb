class Item < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    belongs_to :paper, class_name: "Paper", foreign_key: "papers_id"

    validates :description, presence: true
    validates :unit_price, presence: true
    validates :unit, presence: true
    validates :sort_id, presence: true
    validates :is_deleted, presence: false
    validates :papers_id, presence: true
    validates :users_id, presence: true
end
