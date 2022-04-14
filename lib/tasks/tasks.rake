namespace :tasks do
  desc "Статистика"
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
end
