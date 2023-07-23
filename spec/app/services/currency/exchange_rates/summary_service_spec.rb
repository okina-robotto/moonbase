describe Currency::ExchangeRates::SummaryService do
  context :call do
    Given { create(:currency_exchange_rate) }

    When(:rates) do
      Currency::ExchangeRates::SummaryService.new.call
    end

    Then { expect(rates).to be_truthy }
  end
end
