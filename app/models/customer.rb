class Customer < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    belongs_to :paper, class_name: "Paper", foreign_key: "papers_id"
    
    validates :name, presence: true
    validates :address, presence: true
    validates :phone, presence: true
    validates :is_deleted, presence: false
    validates :users_id, presence: true
end
