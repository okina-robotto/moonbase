module Api
  module V1
    module Amazon
      module Reports
        module Ingest
          class IndexController < Api::Controller
            def index
              result = ::Amazon::Reports::Ingest::ProcessService.new(user_id: params[:user_id]).call
              head 200 if result.success?
            end
          end
        end
      end
    end
  end
end
