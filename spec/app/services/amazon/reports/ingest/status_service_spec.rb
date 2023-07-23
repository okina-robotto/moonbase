describe Amazon::Reports::Ingest::StatusService do
  context :call do
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:key) { "#{user_id}/unprocessed/2019Dec1-2019Dec31CustomTransaction.csv" }

    context :processing do
      before do
        allow(Sidekiq::Queue).to receive_message_chain(:new, :find_job).and_return(Sidekiq::Queue.new({}))
      end

      Sidekiq::Testing.fake! do
        When(:job_id) { ::Amazon::Reports::Ingest::CustomTransactions::IngestJob.perform_async user_id, key }
        When(:status) { Amazon::Reports::Ingest::StatusService.new(user_id:, job_list: [job_id]).call }

        Then { expect(status.complete?).to be_falsey }
        And { expect(::Amazon::Reports::Ingest::StatusJob).to have_enqueued_sidekiq_job user_id, [job_id] }
      end
    end

    context :complete do
      before do
        allow(Sidekiq::Queue).to receive_message_chain(:new, :find_job).and_return(nil)
      end

      Given(:job_id) { "3e7b6ea30487f366cbfb56aa" }

      Sidekiq::Testing.fake! do
        When(:status) { Amazon::Reports::Ingest::StatusService.new(user_id:, job_list: [job_id]).call }

        Then { expect(status.complete?).to be_truthy }
      end
    end
  end
end
