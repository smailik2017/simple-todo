require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task setup: :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    Resque.redis = Redis.new Rails.application.config_for(:queue)
    Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")
  end
end
