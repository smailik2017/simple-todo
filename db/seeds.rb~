# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Item.delete_all
Task.delete_all    
User.delete_all
Role.delete_all
State.delete_all

USERS_COUNT = 10
TASKS_COUNT = 20
ITEMS_COUNT = 100

### Create States for Tasks and Items ###
State.create do |s|
  s.id = 9001
  s.name = 'in progress'
end

State.create do |s|
  s.id = 9002
  s.name = 'finished'
end

State.create do |s|
  s.id = 9003
  s.name = 'canceled'
end

### Create Roles for Users ###
Role.create do |r|
  r.id = 9001
  r.name = 'admin'
  r.description = 'Administrator'
end

Role.create do |r|
  r.id = 9002
  r.name = 'user'
  r.description = 'User'
end

### Create Users ###
user_id = 9000
hash_users = USERS_COUNT.times.map do 
  user_id += 1
  {
    id: user_id,
    name: FFaker::Internet.user_name[0..16],
    email: FFaker::Internet.safe_email,
    role_id: rand(9001..9002),
    active: rand(0..1) == 0 ? false : true
  }
end

User.create! hash_users

### Create Tasks ###
task_id = 9000
hash_tasks = TASKS_COUNT.times.map do
  task_id += 1
  {
    id: task_id,
    name: FFaker::Lorem.sentence,
    description: FFaker::Lorem.paragraph,
    state_id: rand(9001..9003),
    user_id: rand(9001..9010)
  }
end

Task.create! hash_tasks

### Create Items for Tasks ###
item_id = 9000
hash_items = ITEMS_COUNT.times.map do
  item_id += 1
  {
    id: item_id,
    name: FFaker::Lorem.sentence,
    task_id: rand(9001..9010),
    state_id: rand(9001..9003)
  }
end

Item.create! hash_items

