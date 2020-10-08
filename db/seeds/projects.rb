require "faker"

puts "Generation of fake Projects"
4.times do
  dummy_project = {
    name: Faker::Lorem.sentence(word_count: 3),
    summary: Faker::Lorem.paragraph(sentence_count: 5),
    start_date: Faker::Date.between(from: 4.months.ago, to: 3.months.ago),
    end_date: Faker::Date.between(from: 2.months.ago, to: Date.today)
  }
  puts dummy_project
  Project.create(dummy_project)
end