class Duty < ApplicationRecord
  validates :name, presence: true
  
  has_many :duty_users, dependent: :destroy
  has_many :users, through: :duty_users
  has_many :rosters
end
