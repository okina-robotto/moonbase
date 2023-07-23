describe Currency::ExchangeRates::SyncService do
  context :call do
    When do
      VCR.use_cassette("app/services/currency/exchange_rates/sync_service", match_requests_on: %i[body method]) do
        Currency::ExchangeRates::SyncService.new.call
      end
    end
    When(:currencies) { Currency::ExchangeRate.count }

    Then { expect(currencies).to be > 1 }
  end
end
