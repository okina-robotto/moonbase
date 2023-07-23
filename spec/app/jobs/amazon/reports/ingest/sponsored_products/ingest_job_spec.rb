describe Amazon::Reports::Ingest::SponsoredProducts::IngestJob do
  context :perform do
    Given { create(:currency_exchange_rate, code: "USD", exchange_rate: 1.0) }
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:key) { "#{user_id}/unprocessed/Sponsored Products Advertised product report.xlsx" }

    Sidekiq::Testing.inline! do
      When do
        VCR.use_cassette("app/jobs/amazon/reports/ingest/sponsored_products/ingest_job", match_requests_on: %i[body method]) do
          Amazon::Reports::Ingest::SponsoredProducts::IngestJob.new.perform user_id, key
        end
      end

      Then { expect(::Amazon::SponsoredProduct.count).to be > 1 }
    end
  end
end
