require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "simplecov"

SimpleCov.start :rails do
  add_filter "channels"
  add_filter "mailers"
  add_filter "spec"
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  # config.use_active_record          = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
end
