FactoryBot.define do
  factory :roster do
    date {Faker::Date.between(from: 13.days.ago, to: 3.days.from_now)}
    association :duty
    association :user
  end
end
