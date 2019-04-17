if User.count.zero?
  puts 'User admin'
  User.create!(first_name: 'Daniel', last_name: 'Van Der Wel', email: 'dane105@mail.ru', password: '123123', password_confirmation: '123123', admin: true)
  User.create!(first_name: 'TestTest', last_name: 'TestTest', email: 'test105@mail.ru', password: '123123', password_confirmation: '123123', admin: false)
end