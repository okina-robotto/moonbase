module Lyticaa
  module Announcement
    class Error
      class << self
        def capture(exception)
          cause = exception.cause || exception
          log_error(cause.message)
        rescue StandardError => e
          [exception, e].each { |ee| log_error(ee.message) }
        end

        private

        def log_error(message)
          Announcement::Diagnostic.new.log_error(message)
        end
      end
    end
  end
end
