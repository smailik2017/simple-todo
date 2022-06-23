# frozen_string_literal: true

namespace :notify do
  desc 'Уведомить об истечении срока задач'
  task execute: :environment do
    User.all.each do |user|
      tasks = user.tasks.where('deadline - CURRENT_DATE <= 1').in_progress
      NotifyMailer.user_deadlines(user, tasks).deliver_now unless tasks.empty?
    end
  end
end
