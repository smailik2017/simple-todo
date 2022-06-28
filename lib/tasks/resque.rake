# require_relative 'resque_test/resque_test'
# require 'resque_scheduler/tasks'

namespace :resque do
  task setup: :environment do
    # require 'resque'
    # require 'resque_scheduler'
    # require 'resque/scheduler'

    # Resque.schedule = YAML.load_file('config/resque_conf.yml')

    Resque.schedule = YAML.load_file(File.join(Rails.root, 'config/resque_conf.yml')) # load the schedule

    Resque.redis = Redis.new Rails.application.config_for(:queue)

    # require 'jobs'
  end

end
