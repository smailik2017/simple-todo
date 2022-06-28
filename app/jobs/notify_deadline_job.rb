class NotifyDeadlineJob
  @queue = :default

  def self.perform
    User.all.each do |user|
      tasks = user.tasks.where('deadline - CURRENT_DATE <= 1').in_progress
      NotifyMailer.user_deadlines(user, tasks).deliver_now unless tasks.empty?
    end
    puts "Task (Notify Deadline) completted successfully"
  end
end
