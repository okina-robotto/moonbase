module Api
  module V1
    module Currency
      module ExchangeRates
        class IndexController < Api::Controller
          def index
            exchange_rates = ::Currency::ExchangeRates::SummaryService.new.call
            return head 404 if exchange_rates.empty?

            render json: exchange_rates.as_json(except: :id)
          end
        end
      end
    end
  end
end
