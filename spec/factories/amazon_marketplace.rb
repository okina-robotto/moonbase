FactoryBot.define do
  factory :amazon_marketplace, class: ::Amazon::Marketplace do
    amazon_marketplace_id { SecureRandom.uuid }
    name { Faker::Internet.domain_name }
    association :currency_exchange_rate, factory: :currency_exchange_rate
  end
end
