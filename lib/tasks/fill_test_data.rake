namespace :fill_test_data do
  desc "TODO"
  task execute: :environment do
# Deleating all tables #
    Task.delete_all    
    User.delete_all
    Role.delete_all
    State.delete_all
    Item.delete_all

    # Roles create #
    puts 'Creating ROLES'
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

# States create #
    puts 'Creating STATES'

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

# User create #
    puts 'Creating USERS'
    
    User.create do |u|
      u.id = 9001
      u.name = 'user1'
      u.email = 'email1@mail.ru'
      u.role_id = 9001
      u.active = true
    end

    User.create do |u|
      u.id = 9002
      u.name = 'user2'
      u.email = 'email2@mail.ru'
      u.role_id = 9002
      u.active = true
    end

    User.create do |u|
      u.id = 9003
      u.name = 'user3'
      u.email = 'email3@mail.ru'
      u.role_id = 9002
      u.active = true
    end

    User.create do |u|
      u.id = 9004
      u.name = 'user4'
      u.email = 'email4@mail.ru'
      u.role_id = 9002
      u.active = true
    end

    User.create do |u|
      u.id = 9005
      u.name = 'user5'
      u.email = 'email5@mail.ru'
      u.role_id = 9002
      u.active = true
    end
# Creating TASKS
    puts 'creating TASKS'
    task_id = 9001
    (9001..9005).each do |u|
      (1..3).each do |t_ind|
        Task.create do |t|
          t.id = task_id
          task_id += 1
          t.name = "Task user #{u}"
          t.description = "Task User"
          t.user_id = u
          t.state_id = rand(9001..9003) 
        end
      end
    end

# Creating ITEMS
    puts 'creating ITEMS'
    item_id = 9001
    (9001..9015).each do |t|
      (1..3).each do |i_ind|
        Item.create do |i|
          i.id = item_id
          item_id += 1
          i.name = "Item task #{t}"
          i.task_id = t
          i.state_id = rand(9001..9003) 
        end
      end
    end


  end

end
