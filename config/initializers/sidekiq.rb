Sidekiq.configure_server do |config|
  schedule_file = "config/schedule.yml"

  if File.exist? schedule_file
    schedule = ERB.new(File.read schedule_file).result
    Sidekiq::Cron::Job.load_from_hash YAML.load(schedule)
  end
end
