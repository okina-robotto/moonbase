describe Lyticaa::Fixer::Client do
  context :exchange_rates do
    When(:exchange_rates) do
      VCR.use_cassette("app/lib/lyticaa/fixer/client", match_requests_on: %i[body method]) do
        Lyticaa::Fixer::Client.exchange_rates
      end
    end

    Then { expect(exchange_rates).to be_truthy }
    And { expect(exchange_rates.count).to be > 1 }
  end
end
