describe Amazon::Reports::Ingest::ProcessJob do
  context :perform do
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:custom_transactions) { "#{user_id}/unprocessed/2019Dec1-2019Dec31CustomTransaction.csv" }
    Given(:sponsored_products) { "#{user_id}/unprocessed/Sponsored Products Advertised product report.xlsx" }

    Sidekiq::Testing.inline! do
      When do
        VCR.use_cassette("app/jobs/amazon/reports/ingest/process_job", match_requests_on: %i[body method]) do
          Amazon::Reports::Ingest::ProcessJob.new.perform user_id
        end
      end

      Then { expect(Amazon::Reports::Ingest::CustomTransactions::IngestJob).to have_enqueued_sidekiq_job(user_id, custom_transactions) }
      And { expect(Amazon::Reports::Ingest::SponsoredProducts::IngestJob).to have_enqueued_sidekiq_job(user_id, sponsored_products) }
    end
  end
end
