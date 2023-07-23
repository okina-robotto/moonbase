require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Moonbase
  class Application < Rails::Application
    config.load_defaults 7.0
    config.filter_parameters << :password
    config.active_record.schema_format = :sql
    config.api_only = true

    Raven.configure do |config|
      config.dsn = ENV["SENTRY_DSN"]
      config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    end
  end
end
