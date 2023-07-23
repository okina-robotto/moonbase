describe Amazon::Reports::PublishService do
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
    Given { create(:currency_exchange_rate, code: "USD", exchange_rate: 1.0) }
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:prefix) { "#{user_id}/unprocessed/" }
    Given(:custom_transactions) { "2019Dec1-2019Dec31CustomTransaction.csv" }
    Given(:sponsored_products) { "Sponsored Products Advertised product report.xlsx" }

    Sidekiq::Testing.inline! do
      When do
        VCR.use_cassette("app/services/amazon/reports/publish_service/custom_transactions", match_requests_on: %i[body method]) do
          ::Amazon::Reports::Ingest::CustomTransactions::IngestJob.new.perform user_id, "#{prefix}#{custom_transactions}", false
        end
      end
      When do
        VCR.use_cassette("app/services/amazon/reports/publish_service/sponsored_products", match_requests_on: %i[body method]) do
          ::Amazon::Reports::Ingest::SponsoredProducts::IngestJob.new.perform user_id, "#{prefix}#{sponsored_products}", false
        end
      end
      When { ::Amazon::Reports::PublishService.new(user_id:).call }
      When(:cached) { Rails.cache.read("#{user_id}/all_time") }

      Then { expect(cached).to be_truthy }
      And { expect(cached.try(:[], :custom_transactions).count).to be > 1 }
      And { expect(cached.try(:[], :sponsored_products).count).to be > 1 }
    end
  end
end
