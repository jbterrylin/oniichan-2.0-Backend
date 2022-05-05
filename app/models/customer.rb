class Customer < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    belongs_to :paper, class_name: "Paper", foreign_key: "paper_id"
end
