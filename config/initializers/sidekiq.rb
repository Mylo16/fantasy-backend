# config/initializers/sidekiq.rb
require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq::Scheduler.dynamic = true
Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path("../../sidekiq_schedule.yml", __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end
