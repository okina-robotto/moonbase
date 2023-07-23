module Expenses
  class Other < ApplicationRecord
    include Lyticaa::Uuid

    belongs_to :currency_exchange_rate, class_name: "Currency::ExchangeRate",
               foreign_key: :currency_exchange_rate_id

    validates_presence_of :expenses_other_id
    validates_presence_of :user_id
    validates_presence_of :amount
    validates_presence_of :date_time

    validates_format_of :expenses_other_id, with: VALID_UUID
    validates_format_of :user_id, with: VALID_UUID
  end
end
