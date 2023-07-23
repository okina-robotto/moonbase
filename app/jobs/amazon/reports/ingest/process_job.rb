module Amazon
  module Reports
    module Ingest
      class ProcessJob < ApplicationWorker
        sidekiq_options queue: :critical, lock: :until_and_while_executing, retry: 10

        def perform(user_id)
          FilesService.new(user_id:, key: "unprocessed").call
        end
      end
    end
  end
end
