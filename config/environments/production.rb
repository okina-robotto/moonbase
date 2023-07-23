require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.cache_store = :mem_cache_store,
    (ENV["MEMCACHIER_SERVERS"] || "").split(","), {
      username: ENV["MEMCACHIER_USERNAME"],
      password: ENV["MEMCACHIER_PASSWORD"],
      failover: false,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2,
      down_retry_delay: 60,
      pool_size: 5
    }
end
