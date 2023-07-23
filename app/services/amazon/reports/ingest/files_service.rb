module Amazon
  module Reports
    module Ingest
      class FilesService < ApplicationService
        REPORTS_BUCKET = ENV["REPORTS_BUCKET"]
        CUSTOM_TRANSACTIONS = /CustomTransaction/
        SPONSORED_PRODUCTS = /Sponsored Products/

        def initialize(opts = {})
          @user_id = opts.fetch(:user_id)
          @key = opts.fetch(:key)
        end

        attr_accessor :user_id, :key

        def call
          process
        end

        private

        def process
          status(ingest)

          OpenStruct.new success?: true
        end

        def ingest
          files.map do |key|
            custom_transactions(key) if key.match CUSTOM_TRANSACTIONS
            sponsored_products(key) if key.match SPONSORED_PRODUCTS
          end.compact
        end

        def files
          @files ||= client.list_files
        end

        def prefix
          "#{user_id}/#{key}"
        end

        def client
          @client ||= Lyticaa::Aws::S3::Client.new(bucket: REPORTS_BUCKET, prefix:)
        end

        def custom_transactions(key)
          CustomTransactions::IngestJob.perform_async user_id, key
        end

        def sponsored_products(key)
          SponsoredProducts::IngestJob.perform_async user_id, key
        end

        def status(job_list)
          StatusJob.perform_in 1.minute, user_id, job_list
        end
      end
    end
  end
end
