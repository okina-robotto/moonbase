describe Amazon::Reports::Ingest::ProcessService do
  context :call do
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }

    Sidekiq::Testing.inline! do
      When do
        ::Amazon::Reports::Ingest::ProcessService.new(user_id:).call
      end

      Then { expect(::Amazon::Reports::Ingest::ProcessJob).to have_enqueued_sidekiq_job user_id }
    end
  end
end
