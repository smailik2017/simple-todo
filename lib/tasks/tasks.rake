# frozen_string_literal: true

namespace :tasks do
  desc 'Статистика'
  task stats: :environment do
    ## User - Tasks count - Items count ##
    puts 'User name | Tasks count | Items count'
    User.all.each do |u|
      tasks_cnt = u.tasks.count
      items_cnt = 0
      u.tasks.each do |t|
        items_cnt += t.items.count
      end
      puts "#{u.name} | #{tasks_cnt} | #{items_cnt}"
    end
  end

  task items4user: :environment do
    ## Items for user ##
    print 'Введите имя пользователя: '
    user_name = gets.chomp
    puts 'Вариант 1'
    ### Вариант 1 ###
    Item.where(task: Task.where(user: User.where(name: user_name))).each do |i|
      puts i.name
    end

    puts 'Вариант 2'
    ### Вариант 2 ###
    sql = "
      select u.name as "'user_name'', t.name as ''task_name'', i.name as ''item_name'"
      from
        items i,
        tasks t,
        users u
      where
        u.id = t.user_id and
        i.task_id = t.id and
        u.name = '#{user_name}'"
    ActiveRecord::Base.connection.execute(sql).each do |res|
      puts res['item_name']
    end
  end
end
