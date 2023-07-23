module Amazon
  module Reports
    module Ingest
      module CustomTransactions
        class IngestService < ApplicationService
          REPORTS_BUCKET = ENV["REPORTS_BUCKET"]

          def initialize(opts = {})
            @user_id = opts.fetch(:user_id)
            @key = opts.fetch(:key)
            @archive = opts.fetch(:archive, true)
          end

          attr_accessor :user_id, :key, :archive

          def call
            process
          end

          private

          def process
            parse&.each do |row|
              params = { user_id:,
                         date_time: row["date/time"],
                         settlement_id: row["settlement id"],
                         amazon_transaction_type: amazon_transaction_type(row["type"]),
                         order_id: row["order id"],
                         sku: row["sku"],
                         description: row["description"],
                         quantity: row["quantity"],
                         amazon_marketplace: amazon_marketplace(row["marketplace"]),
                         amazon_fulfillment: amazon_fulfillment(row["fulfillment"]),
                         amazon_tax_collection_model: amazon_tax_collection_model(row["tax collection model"]),
                         product_sales: row["product sales"]&.to_f,
                         product_sales_tax: row["product sales tax"]&.to_f,
                         shipping_credits: row["shipping credits"]&.to_f,
                         shipping_credits_tax: row["shipping credits tax"]&.to_f,
                         giftwrap_credits: row["gift wrap credits"]&.to_f,
                         giftwrap_credits_tax: row["giftwrap credits tax"]&.to_f,
                         promotional_rebates: row["promotional rebates"]&.to_f,
                         promotional_rebates_tax: row["promotional rebates tax"]&.to_f,
                         marketplace_withheld_tax: row["marketplace withheld tax"]&.to_f,
                         selling_fees: row["selling fees"]&.to_f,
                         fba_fees: row["fba fees"]&.to_f,
                         other_transaction_fees: row["other transaction fees"]&.to_f,
                         other: row["other"]&.to_f,
                         total: row["total"]&.to_f }

              ::Amazon::CustomTransaction.create_concurrently(params)
            end

            complete

            OpenStruct.new(success?: true)
          end

          def parse
            CSV.parse(remove_headers&.join("\r\n"), col_sep: ",", headers: true)
          end

          def remove_headers
            content = contents.split(/[\r\n]+/)
            7.times { content.shift }

            content
          end

          def contents
            @contents ||= download&.body&.read
          end

          def download
            @download ||= client.file(key)
          end

          def client
            @client ||= Lyticaa::Aws::S3::Client.new(bucket: REPORTS_BUCKET)
          end

          def amazon_transaction_type(name)
            @amazon_transaction_type ||= ::Amazon::TransactionType.where(name:)&.first
          end

          def amazon_marketplace(name)
            ::Amazon::Marketplace.where(name:)&.first
          end

          def amazon_fulfillment(name)
            @amazon_fulfillment ||= ::Amazon::Fulfillment.where(name:)&.first
          end

          def amazon_tax_collection_model(name)
            @amazon_tax_collection_model ||= ::Amazon::TaxCollectionModel.where(name:)&.first
          end

          def complete
            return if !archive

            client.copy_file("#{user_id}/processed/#{Time.now.to_i}/#{key.split("/").last}",
                             CGI.escape("#{REPORTS_BUCKET}/#{key}"))
            client.delete_file(key)
          end
        end
      end
    end
  end
end
