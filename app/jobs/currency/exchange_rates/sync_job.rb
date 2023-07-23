module Currency
  module ExchangeRates
    class SyncJob < ApplicationWorker
      sidekiq_options queue: :high, lock: :until_and_while_executing, retry: 10

      def perform
        SyncService.new.call
      end
    end
  end
end
