class DeadlineTasksCleanupJob < ApplicationJob
  queue_as :default

  def perform(ago = 1.week.ago)
    Task.where('deadline < ?', ago).update(done: true)
    # FileUtils.touch Rails.root.join('tmp/hello_from_whenever.txt')
  end
end
