source "https://rubygems.org"

source "https://rubygems.org" do
  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  ruby "3.2.2"

  gem "bootsnap", require: false
  gem "aws-sdk-rails"
  gem "aws-sdk-s3"
  gem "dalli"
  gem "fastercsv"
  gem "haml"
  gem "httparty"
  gem "pg", "~> 1.1"
  gem "puma", "~> 5.0"
  gem "rack-cors", "~> 2.0.1"
  gem "rails", "~> 7.0.6"
  gem "roo"
  gem "sentry-raven"
  gem "sidekiq", "~> 7.1.2"
  gem "sidekiq-cron", "~> 1.10.1"
  gem "sidekiq-status"
  gem "sidekiq-unique-jobs"
end

group :development do
  gem "debug", "~> 1.8",  platforms: %i[ mri mingw x64_mingw ]
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner-active_record"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec"
  gem "rspec-given"
  gem "rspec-rails"
  gem "rspec-sidekiq"
  gem "rubocop"
  gem "rubocop-packaging"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "simplecov", require: false
  gem "timecop"
  gem "vcr"
  gem "webmock"
end

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
