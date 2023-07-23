describe Amazon::Reports::Ingest::CustomTransactions::IngestService do
  context :call do
    Given { create(:amazon_marketplace, name: "amazon.com") }
    Given do
      create(:amazon_transaction_type, :order)
      create(:amazon_transaction_type, :refund)
      create(:amazon_transaction_type, :service_fee)
      create(:amazon_transaction_type, :adjustment)
      create(:amazon_transaction_type, :transfer)
      create(:amazon_transaction_type, :fba_inventory_fee)
    end
    Given { create(:amazon_fulfillment, :amazon) }
    Given { create(:amazon_tax_collection_model, :marketplace_facilitator) }
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:key) { "#{user_id}/unprocessed/2019Dec1-2019Dec31CustomTransaction.csv" }
    Given(:ingest_service) do
      ::Amazon::Reports::Ingest::CustomTransactions::IngestService.new(user_id:, key:)
    end

    When(:result) do
      VCR.use_cassette("app/services/amazon/reports/ingest/custom_transactions/ingest_service", match_requests_on: %i[body method]) do
        ingest_service.call
      end
    end

    Then { expect(result.success?).to be_truthy }
    And { expect(::Amazon::CustomTransaction.count).to be > 1 }
  end
end
