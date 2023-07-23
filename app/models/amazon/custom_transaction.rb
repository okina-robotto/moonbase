module Amazon
  class CustomTransaction < ApplicationRecord
    belongs_to :amazon_transaction_type, class_name: "Amazon::TransactionType",
               foreign_key: :amazon_transaction_type_id
    belongs_to :amazon_marketplace, class_name: "Amazon::Marketplace",
               foreign_key: :amazon_marketplace_id
    belongs_to :amazon_fulfillment, class_name: "Amazon::Fulfillment",
               foreign_key: :amazon_fulfillment_id
    belongs_to :amazon_tax_collection_model, class_name: "Amazon::TaxCollectionModel",
               foreign_key: :amazon_tax_collection_model_id

    class << self
      def by_date_range(user_id, date_range, limit = 1000)
        "::Amazon::CustomTransactions::#{date_range.to_s.camelize}".
            constantize.
            where(user_id:).
            limit(limit)
      end
    end
  end
end
