require "faker"

user_ids = User.pluck(:id)
project_ids = Project.pluck(:id)
available_statuses = ["new", "in progress", "in review", "done"]

def get_dummy_task(user_ids, project_ids, available_statuses)
  {
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    status: available_statuses.sample,
    assignee: user_ids.sample,
    created_by_id: user_ids.sample,
    project_id: project_ids.sample
  }
end

puts "Generation of fake Stories"
35.times do
  dummy_story = get_dummy_task(user_ids, project_ids, available_statuses)
  puts dummy_story
  Story.create(dummy_story)
end

puts "Generation of fake Issues"
35.times do
  dummy_issue = get_dummy_task(user_ids, project_ids, available_statuses)
  puts dummy_issue
  Issue.create(dummy_issue)
end
