require "faker"

FactoryBot.define do
  factory :project do
    name { Faker::Lorem.sentence(word_count: 3) }
    summary { Faker::Lorem.paragraph(sentence_count: 5) }
    start_date { Faker::Date.between(from: 4.months.ago, to: 3.months.ago) }
    end_date { Faker::Date.between(from: 2.months.ago, to: Date.today) }

    trait :with_tasks_and_comments do
      after(:project) do |project|
        create_list :task, 3, project: project
      end
    end
  end
end

