FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    amount { 100 }
  end
end
