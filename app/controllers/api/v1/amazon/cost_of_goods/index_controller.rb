module Api
  module V1
    module Amazon
      module CostOfGoods
        class IndexController < Api::Controller
          def index
            result = ::Amazon::CostOfGoods::RecordService.new(params).call
            head 200 if result.success?
            head 422 if result.error?
          end
        end
      end
    end
  end
end
