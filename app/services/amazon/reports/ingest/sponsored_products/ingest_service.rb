module Amazon
  module Reports
    module Ingest
      module SponsoredProducts
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
            sheet.each do |row|
              next if headers == row

              combined = hash(row)

              params = { user_id:,
                         date_time: combined["Date"],
                         portfolio_name: combined["Portfolio name"],
                         currency_exchange_rate: currency_exchange_rate(combined["Currency"]),
                         campaign_name: combined["Campaign Name"],
                         ad_group_name: combined["Ad Group Name"],
                         sku: combined["Advertised SKU"],
                         asin: combined["Advertised ASIN"],
                         impressions: combined["Impressions"]&.to_i,
                         clicks: combined["Clicks"]&.to_i,
                         ctr: combined["Click-Thru Rate (CTR)"]&.to_f,
                         cpc: combined["Cost Per Click (CPC)"]&.to_f,
                         spend: combined["Spend"]&.to_f,
                         total_sales: combined["7 Day Total Sales "]&.to_f,
                         acos: combined["Total Advertising Cost of Sales (ACoS) "]&.to_f,
                         roas: combined["Total Return on Advertising Spend (RoAS)"]&.to_f,
                         total_orders: combined["7 Day Total Orders (#)"]&.to_i,
                         total_units: combined["7 Day Total Units (#)"]&.to_i,
                         conversion_rate: combined["7 Day Conversion Rate"]&.to_f,
                         advertised_sku_units: combined["7 Day Advertised SKU Units (#)"]&.to_i,
                         other_sku_units: combined["7 Day Other SKU Units (#)"]&.to_i,
                         advertised_sku_sales: combined["7 Day Advertised SKU Sales "]&.to_f,
                         other_sku_sales: combined["7 Day Other SKU Sales "]&.to_f
              }

              ::Amazon::SponsoredProduct.create_concurrently(params)
            end

            complete

            OpenStruct.new(success?: true)
          end

          def hash(row)
            Hash[headers.zip(row)]
          end

          def headers
            @headers ||= workbook&.sheet(0)&.first
          end

          def sheet
            workbook.sheet(0)
          end

          def workbook
            @workbook ||= Roo::Excelx.new client.signed_url(key)
          end

          def client
            @client ||= Lyticaa::Aws::S3::Client.new(bucket: REPORTS_BUCKET)
          end

          def currency_exchange_rate(code)
            ::Currency::ExchangeRate.where(code:)&.first
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
