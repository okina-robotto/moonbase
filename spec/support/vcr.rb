require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "#{::Rails.root}/spec/fixtures"
  c.hook_into :webmock
  c.ignore_localhost = true
end
