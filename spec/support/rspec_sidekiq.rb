require "rspec-sidekiq"

RSpec::Sidekiq.configure do |config|
  config.clear_all_enqueued_jobs = true
  config.warn_when_jobs_not_processed_by_sidekiq = false

  Sidekiq.redis(&:flushdb)
end
