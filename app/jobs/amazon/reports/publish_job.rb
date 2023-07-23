module Amazon
  module Reports
    class PublishJob < ApplicationWorker
      sidekiq_options queue: :critical, lock: :until_and_while_executing, retry: 10

      def perform(user_id)
        PublishService.new(user_id:).call
      end
    end
  end
end
