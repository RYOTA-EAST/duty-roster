class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :duty_users, dependent: :destroy
  has_many :duties, through: :duty_users, dependent: :destroy
  has_many :rosters, dependent: :destroy
end
