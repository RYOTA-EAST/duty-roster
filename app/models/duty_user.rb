class DutyUser < ApplicationRecord
  belongs_to :duty
  belongs_to :user
end
