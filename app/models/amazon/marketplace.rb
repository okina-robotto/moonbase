module Amazon
  class Marketplace < ApplicationRecord
    belongs_to :currency_exchange_rate, class_name: "Currency::ExchangeRate",
               foreign_key: :currency_exchange_rate_id
  end
end
