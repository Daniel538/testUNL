require "faker"

User.destroy_all

puts "Generation admin user"
User.create(first_name: "Daniel", last_name: "Van Der Wel", email: "dane105@mail.ru",
            password: "123123", admin: true)
User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
            password: "123123", admin: true)

puts "Generation of fake users"
4.times do
  dummy_user = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123",
    admin: false
  }
  User.create(dummy_user)
  puts dummy_user
end
