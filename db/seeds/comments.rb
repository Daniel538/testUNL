require "faker"

@user_ids = User.pluck(:id)
task_ids = Task.pluck(:id)

puts "Generation of fake Comments"
def generate_dummy_comments(type, commentable_ids)
  puts("Generation Comments for " + type)
  10.times do
    dummy_comment = {
      text: Faker::Name.first_name,
      user_id: @user_ids.sample,
      commentable_id: commentable_ids.sample,
      commentable_type: type
    }
    Comment.create(dummy_comment)
  end
end

generate_dummy_comments("Task", task_ids)

3.times do
  commentable_ids = Comment.pluck(:id)
  generate_dummy_comments("Comment", commentable_ids)
end
