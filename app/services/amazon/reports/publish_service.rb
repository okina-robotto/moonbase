module Amazon
  module Reports
    class PublishService < ApplicationService
      DATE_RANGE = %i[ today yesterday last_thirty_days previous_thirty_days this_month
                       last_month month_before_last this_month last_month last_month
                       month_before_last last_three_months previous_three_months
                       last_six_months previous_six_months this_year all_time ].freeze

      def initialize(opts = {})
        @user_id = opts.fetch(:user_id)
      end

      attr_accessor :user_id

      def call
        process
      end

      private

      def process
        DATE_RANGE.each do |date_range|
          refresh date_range
          publish date_range
        end
      end

      def refresh(date_range)
        %i[custom_transactions sponsored_products].each do |m|
          "::Amazon::#{m.to_s.camelize}::#{date_range.to_s.camelize}".constantize.refresh!
        end
      end

      def publish(date_range)
        Rails.cache.write("#{user_id}/#{date_range}", generate(date_range))
      end

      def generate(date_range)
        %i[custom_transactions sponsored_products].each_with_object({}) { |m, h| h[m] = send(m, date_range) }
      end

      def custom_transactions(date_range)
        ::Amazon::CustomTransaction.by_date_range(user_id, date_range).as_json
      end

      def sponsored_products(date_range)
        ::Amazon::SponsoredProduct.by_date_range(user_id, date_range).as_json
      end
    end
  end
end
