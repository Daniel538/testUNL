Task.destroy_all
Project.destroy_all
User.destroy_all

require "./db/seeds/users"
require "./db/seeds/projects"
require "./db/seeds/tasks"

