module Api
  module V1
    module Amazon
      module Marketplaces
        class IndexController < Api::Controller
          def index
            marketplaces = ::Amazon::Marketplaces::SummaryService.new.call
            return head 404 if marketplaces.empty?

            render json: marketplaces.as_json(except: :id)
          end
        end
      end
    end
  end
end
