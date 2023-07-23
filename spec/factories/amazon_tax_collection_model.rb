FactoryBot.define do
  factory :amazon_tax_collection_model, class: ::Amazon::TaxCollectionModel do
    trait :marketplace_facilitator do
      name { "MarketplaceFacilitator" }
    end
  end
end
