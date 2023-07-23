module Currency
  module ExchangeRates
    class SummaryService < ApplicationService
      def call
        exchange_rates
      end

      private

      def exchange_rates
        Currency::ExchangeRate.select(:currency_exchange_rate_id, :code, :exchange_rate).all
      end
    end
  end
end
