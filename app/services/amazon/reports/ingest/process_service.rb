module Amazon
  module Reports
    module Ingest
      class ProcessService < ApplicationService
        def initialize(opts = {})
          @user_id = opts.fetch(:user_id)
        end

        attr_accessor :user_id

        def call
          download

          OpenStruct.new success?: true
        end

        private

        def download
          ProcessJob.perform_async user_id
        end
      end
    end
  end
end
