module Lyticaa
  module Announcement
    class Diagnostic
      def log_info(message, params = {})
        Rails.logger.info(log_entry(message, params))
      end

      def log_error(message, params = {})
        Rails.logger.error(log_entry(message, params))
      end

      def raise_error(klass, message, params = {})
        log_error message, params
        raise klass, log_entry(message, params)
      end

      protected

      def log_entry(message, params)
        params.merge(message:).map { |k, v| %(#{k}="#{v}") }.join(" ")
      end
    end
  end
end
