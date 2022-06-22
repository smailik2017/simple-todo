namespace :notify do
  desc "TODO"
  task execute: :environment do
    date_now = DateTime.now
    User.all.each do |user|
      tasks = user.tasks.where('deadline - CURRENT_DATE <= 1')
      NotifyMailer.user_deadlines(user, tasks).deliver_now unless tasks.empty?
    end
  end

end
