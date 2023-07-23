describe Amazon::Reports::Ingest::SponsoredProducts::IngestService do
  context :call do
    Given { create(:currency_exchange_rate, code: "USD", exchange_rate: 1.0) }
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:key) { "#{user_id}/unprocessed/Sponsored Products Advertised product report.xlsx" }
    Given(:ingest_service) do
      ::Amazon::Reports::Ingest::SponsoredProducts::IngestService.new(user_id:, key:)
    end

    When(:result) do
      VCR.use_cassette("app/services/amazon/reports/ingest/sponsored_products/ingest_service", match_requests_on: %i[body method]) do
        ingest_service.call
      end
    end

    Then { expect(result.success?).to be_truthy }
    And { expect(::Amazon::SponsoredProduct.count).to be > 1 }
  end
end
