module Api
  module V1
    module Expenses
      module Others
        class IndexController < Api::Controller
          def index
            result = ::Expenses::Others::RecordService.new(params).call
            head 200 if result.success?
            head 422 if result.error?
          end
        end
      end
    end
  end
end
