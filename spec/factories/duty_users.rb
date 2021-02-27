FactoryBot.define do
  factory :duty_user do
    association :duty
    association :user
  end
end
