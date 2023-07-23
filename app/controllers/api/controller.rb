module Api
  class Controller < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

    private

    def authenticate
      authenticate_or_request_with_http_token do |token, _options|
        ActiveSupport::SecurityUtils.secure_compare(token, ENV["API_TOKEN"])
      end
    end

    def current_user
      @current_user ||= authenticate
    end
  end
end
