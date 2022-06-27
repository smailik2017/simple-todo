namespace :deadline_tasks do
  desc "Пометка выполненными устаревших deadline-заданий"
  task cleanup: :environment do
    DeadlineTasksCleanupJob.perform_now(1.week.ago)
  end

end
