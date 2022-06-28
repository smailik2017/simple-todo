class DeadlineTasksCleanupJob
  @queue = :default

  def self.perform(ago = 1.week.ago)
    Task.where('deadline < ?', ago).update(done: true)
    puts "Task (Cleanup Deadline) completed successfuly"
  end
end
