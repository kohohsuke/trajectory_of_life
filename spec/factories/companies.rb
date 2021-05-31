FactoryBot.define do
  factory :company do
    name           { Faker::Company.name }
    post_code      { '123-4567' }
    address        { Faker::Address.city }
    website        { Faker::Internet.url }
    category_id    { 1 }
    occupation_id  { 1 }
    characteristic { Faker::Lorem.characters(number: 10) }
    first_reason   { Faker::Lorem.characters(number: 10) }
    second_reason  { Faker::Lorem.characters(number: 10) }
    third_reason   { Faker::Lorem.characters(number: 10) }

    association :user

  end
end
