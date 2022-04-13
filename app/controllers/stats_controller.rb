class StatsController < ApplicationController
  def index
    @users = User.all
    @res = [[]]
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
      @res[i, 0] = 'test'
      @res[i, 1] = 'test'
      @res[i, 2] = 'test'
      @res[i, 3] = 'test'
      @res[i, 4] = 'test'
      @res[i, 5] = 'test'
      @res[i, 6] = 'test'

      i += 1
    end
    puts @res
  end
end
