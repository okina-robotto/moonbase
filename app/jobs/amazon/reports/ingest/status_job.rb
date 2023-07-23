module Amazon
  module Reports
    module Ingest
      class StatusJob < ApplicationWorker
        sidekiq_options queue: :high, lock: :until_and_while_executing, retry: 10

        def perform(user_id, job_list)
          StatusService.new(user_id:, job_list:).call
        end
      end
    end
  end
end
