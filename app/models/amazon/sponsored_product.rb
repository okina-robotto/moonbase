module Amazon
  class SponsoredProduct < ApplicationRecord
    belongs_to :currency_exchange_rate, class_name: "Currency::ExchangeRate",
               foreign_key: :currency_exchange_rate_id

    class << self
      def by_date_range(user_id, date_range, limit = 1000)
        "::Amazon::SponsoredProducts::#{date_range.to_s.camelize}".
            constantize.
            where(user_id:).
            limit(limit)
      end
    end
  end
end
