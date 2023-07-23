module Lyticaa
  module Uuid
    extend ActiveSupport::Concern

    included do
      VALID_UUID = /[0-9A-F]{8}-[0-9A-F]{4}-[1-5][0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}/i
    end

    class_methods do; end
  end
end
