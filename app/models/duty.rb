class Duty < ApplicationRecord
  validates :name, presence: true
  
  has_many :duty_users
  has_many :users, through: :duty_users
end
