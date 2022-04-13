namespace :testtask do
  desc "TODO"
  task test: :environment do
    res = [[]]
    i = 0
    User.all.each do |u|
      tasks_cnt = u.tasks.count
      tasks_cnt_not_finished = u.tasks.where('state_id <> ?', 9001).count
      items_cnt = 0
      items_cnt_not_finished = 0
      u.tasks.each do |t|
        items_cnt += t.items.count
        items_cnt_not_finished += t.items.where('state_id <> ?', 9001).count
      end
      res[i][0] = "str = #{i}, 0"
      res[i][1] = "str = #{i}, 1"
      res[i][2] = "str = #{i}, 2"
      res[i][3] = "str = #{i}, 3"
      res[i][4] = "str = #{i}, 4"
      res[i][5] = "str = #{i}, 5"
      res[i][6] = "str = #{i}, 6"

      i += 1
    end  
    n = i - 1
    for i in 0..n
      puts "#{res[i][0]}"
      puts "#{res[i][1]}"
      puts "#{res[i][2]}"
      puts "#{res[i][3]}"
      puts "#{res[i][4]}"
      puts "#{res[i][5]}"
      puts "#{res[i][6]}"
    end

    puts "#{res[0[0]]}"
  end

end
