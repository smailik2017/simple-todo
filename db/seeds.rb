# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Item.destroy_all
Task.destroy_all
User.destroy_all
Role.destroy_all
Comment.destroy_all
State.destroy_all

default_role = Role.create!(name: 'Пользователь', code: :default, description: 'Пользователи')
admin_role = Role.create!(name: 'Администратор', code: :admin, description: 'Администраторы')

USERS_COUNT = 10
TASKS_COUNT = 20
ITEMS_COUNT = 100
COMMENTS_COUNT = 200

### Create States for Tasks and Items ###
State.create!(name: 'in progress')
State.create!(name: 'finished')
State.create!(name: 'canceled')

### Create Users ###
admin_email = 'admin@example.com'
user_pass = '111111'

hash_users = USERS_COUNT.times.map do 
  email = FFaker::Internet.safe_email
  {
    name: FFaker::Internet.user_name[0..16],
    email: email,
    password: user_pass,
    role: default_role,
    # active: rand(0..1) == 0 ? false : true
    active: true
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

User.create!  name: 'Администратор', 
              email:  admin_email,
              password: user_pass,
              role: admin_role,
              active: true
