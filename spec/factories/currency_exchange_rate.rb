FactoryBot.define do
  factory :currency_exchange_rate, class: ::Currency::ExchangeRate do
    currency_exchange_rate_id { SecureRandom.uuid }
    code { Faker::Currency.code }
    exchange_rate { Faker::Number.decimal l_digits: 2 }
  end
end
