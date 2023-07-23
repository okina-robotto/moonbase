FactoryBot.define do
  factory :amazon_transaction_type, class: ::Amazon::TransactionType do
    trait :order do
      name { "Order" }
    end

    trait :refund do
      name { "Refund" }
    end

    trait :service_fee do
      name { "Service Fee" }
    end

    trait :adjustment do
      name { "Adjustment" }
    end

    trait :transfer do
      name { "Transfer" }
    end

    trait :fba_inventory_fee do
      name { "FBA Inventory Fee" }
    end
  end
end
