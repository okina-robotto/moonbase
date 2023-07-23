describe Currency::ExchangeRates::SyncJob do
  context :perform do
    context :queue do
      When { Currency::ExchangeRates::SyncJob.perform_async }

      Then { expect(Currency::ExchangeRates::SyncJob).to have_enqueued_sidekiq_job }
    end
  end
end
