FactoryBot.define do
  factory :roster do
    date {Faker::Date.forward(days: 5)}
    association :duty
    association :user
  end
end
