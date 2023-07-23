require "sidekiq/api"

module Amazon
  module Reports
    module Ingest
      class StatusService < ApplicationService
        DEFAULT_QUEUE = "critical".freeze

        def initialize(opts = {})
          @user_id = opts.fetch(:user_id)
          @job_list = opts.fetch(:job_list)
        end

        attr_accessor :user_id, :job_list

        def call
          process
        end

        private

        def process
          status.empty? ? complete : processing

          OpenStruct.new complete?: status.empty?
        end

        def status
          job_list.map { |job_id| Sidekiq::Queue.new(DEFAULT_QUEUE).find_job(job_id) }.compact
        end

        def processing
          StatusJob.perform_at 1.minute, user_id, job_list
        end

        def complete
          ::Amazon::Reports::PublishJob.perform_async user_id
        end
      end
    end
  end
end
