describe Amazon::Reports::Ingest::StatusJob do
  before do
    allow(Sidekiq::Queue).to receive_message_chain(:new, :find_job).and_return(nil)
  end

  context :perform do
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:job_id) { "3e7b6ea30487f366cbfb56aa" }

    Sidekiq::Testing.inline! do
      When { ::Amazon::Reports::Ingest::StatusJob.new.perform user_id, [job_id] }

      Then { expect(::Amazon::Reports::PublishJob).to have_enqueued_sidekiq_job user_id  }
    end
  end
end
