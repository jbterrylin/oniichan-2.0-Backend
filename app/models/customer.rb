class Customer < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "users_id"
    has_many :papers, class_name: "Paper", foreign_key: "customers_id"
    
    validates_presence_of :name, if: Proc.new { |customer| !customer.address? & !customer.phone? }
    validates_presence_of :address, if: Proc.new { |customer| !customer.name? & !customer.phone? }
    validates_presence_of :phone, if: Proc.new { |customer| !customer.name? & !customer.address? }
    validates :is_deleted, presence: false
    validates :users_id, presence: true
end
