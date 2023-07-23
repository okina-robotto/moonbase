describe Amazon::Reports::Ingest::CustomTransactions::IngestJob do
  context :perform do
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

    Sidekiq::Testing.inline! do
      When do
        VCR.use_cassette("app/jobs/amazon/reports/ingest/custom_transactions/ingest_job", match_requests_on: %i[body method]) do
          Amazon::Reports::Ingest::CustomTransactions::IngestJob.new.perform user_id, key
        end
      end

      Then { expect(::Amazon::CustomTransaction.count).to be > 1 }
    end
  end
end
