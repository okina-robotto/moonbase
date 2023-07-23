module Amazon
  module SponsoredProducts
    class LastMonth < ApplicationRecord
      belongs_to :currency_exchange_rate, class_name: "Currency::ExchangeRate",
                 foreign_key: :currency_exchange_rate_id

      class << self
        def table_name
          "#{Amazon::SponsoredProducts.table_name_prefix}last_month"
        end

        def refresh!
          ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW #{table_name}")
        end
      end

      def readonly?
        true
      end
    end
  end
end
