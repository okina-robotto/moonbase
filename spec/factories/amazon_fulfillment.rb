FactoryBot.define do
  factory :amazon_fulfillment, class: ::Amazon::Fulfillment do
    trait :amazon do
      name { "Amazon" }
    end
  end
end
