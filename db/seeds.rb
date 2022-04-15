# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Comment.delete_all
Item.delete_all
Task.delete_all    
User.delete_all
Role.delete_all
State.delete_all
Comment.delete_all

USERS_COUNT = 10
TASKS_COUNT = 20
ITEMS_COUNT = 100
COMMENTS_COUNT = 200

### Create States for Tasks and Items ###
State.create do |s|
  s.name = 'in progress'
end

State.create do |s|
  s.name = 'finished'
end

State.create do |s|
  s.name = 'canceled'
end

### Create Roles for Users ###
Role.create do |r|
  r.name = 'admin'
  r.description = 'Administrator'
end

Role.create do |r|
  r.name = 'user'
  r.description = 'User'
end

### Create Users ###
hash_users = USERS_COUNT.times.map do 
  {
    name: FFaker::Internet.user_name[0..16],
    email: FFaker::Internet.safe_email,
    role: Role.all.sample,
    active: rand(0..1) == 0 ? false : true
  }
end

User.create! hash_users

### Create Tasks ###
hash_tasks = TASKS_COUNT.times.map do
  {
    name: FFaker::Lorem.sentence,
    description: FFaker::Lorem.paragraph,
    state: State.all.sample,
    user: User.all.sample
  }
end

Task.create! hash_tasks

### Create Items for Tasks ###
hash_items = ITEMS_COUNT.times.map do
  {
    name: FFaker::Lorem.sentence,
    task: Task.all.sample,
    state: State.all.sample
  }
end

Item.create! hash_items

### Create Comments for Tasks ###
hash_comments = COMMENTS_COUNT.times.map do
  commentable = ((rand(2) == 1) ? Task.all : User.all).sample
  {
    content: FFaker::HipsterIpsum.paragraphs,
    user: User.all.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end

Comment.create! hash_comments