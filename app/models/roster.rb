class Roster < ApplicationRecord
  validates :date, presence: true

  belongs_to :duty
  belongs_to :user
end
