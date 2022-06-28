require 'resque_scheduler'

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

Resque.redis = Redis.new Rails.application.config_for(:queue)