module Amazon
  module Reports
    module Ingest
      module CustomTransactions
        class IngestJob < ApplicationWorker
          sidekiq_options queue: :critical, lock: :until_and_while_executing, retry: 10

          def perform(user_id, key, archive = true)
            IngestService.new(user_id:, key:, archive:).call
          end
        end
      end
    end
  end
end
