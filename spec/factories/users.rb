require "faker"

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Number.number(digits: 8) }
    admin { Faker::Boolean.boolean }
  end
end
