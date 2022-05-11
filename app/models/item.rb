class Item < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    belongs_to :paper, class_name: "Paper", foreign_key: "papers_id"

    validates_presence_of :description, :unless => lambda { self.unit_price.empty? && self.unit.empty? }
    # validates_presence_of :unit_price, :unless => lambda { !self.description.empty? }
    # validates_presence_of :unit, :unless => lambda { !self.description.empty? }
    validates :sort_id, presence: true
    validates :is_deleted, presence: false
    # validates :papers_id, presence: true
    validates :users_id, presence: true
end
