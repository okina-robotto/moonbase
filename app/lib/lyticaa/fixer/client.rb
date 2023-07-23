module Lyticaa
  module Fixer
    class Client
      class << self
        BASE_CURRENCY = "USD".freeze
        HOSTNAME      = "data.fixer.io".freeze
        ENDPOINT      = "/api/latest".freeze
        SUCCESS_CODE  = 200

        def exchange_rates
          if error? response.code
            response.code diagnostic.log_error "failed to get exchange rates", error_code: response.code
            return {}
          end

          JSON.parse response.body if success? response.code
        end

        private

        def response
          @response ||= HTTParty.get url, params
        end

        def uri
          ENDPOINT
        end

        def url
          "https://#{HOSTNAME}#{uri}"
        end

        def access_key
          ENV["FIXER_ACCESS_KEY"]
        end

        def params
          { query: { access_key:, format: 1, base: BASE_CURRENCY } }
        end

        def error?(response_code)
          true if response_code != SUCCESS_CODE
        end

        def success?(response_code)
          true if response_code == SUCCESS_CODE
        end

        def diagnostic
          @diagnostic ||= Lyticaa::Announcement::Diagnostic.new
        end
      end
    end
  end
end
