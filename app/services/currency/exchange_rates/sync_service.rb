module Currency
  module ExchangeRates
    class SyncService < ApplicationService
      def call
        sync
      end

      private

      def sync
        exchange_rates.try(:[], "rates").each do |code, exchange_rate|
          currency = Currency::ExchangeRate.create_or_find_by(code:)
          currency.update(exchange_rate:)
        end
      end

      def exchange_rates
        @exchange_rates ||= Lyticaa::Fixer::Client.exchange_rates
      end
    end
  end
end
