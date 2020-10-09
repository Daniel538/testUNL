require "faker"

available_statuses = ["to do", "in progress", "in review", "done"]

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    status { available_statuses.sample }
    type { Issue }
    association :assignee, factory: :user
    association :created_by, factory: :user
    association :project, factory: :project

    trait :with_comments do
      after(:task) do |task|
        create_list :comment, 3, task: task
      end
    end
  end
end
