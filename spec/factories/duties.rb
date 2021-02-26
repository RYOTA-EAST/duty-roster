FactoryBot.define do
  factory :duty do
    name {Faker::Name.last_name}
  end
end