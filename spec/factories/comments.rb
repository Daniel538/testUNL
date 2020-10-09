require "faker"

FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence(word_count: 3) }
    association :commentable, factory: [:task]
    association :user, factory: :user
  end
end
