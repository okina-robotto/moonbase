module Amazon
  module CustomTransactions
    class AllTime < ApplicationRecord
      belongs_to :amazon_transaction_type, class_name: "Amazon::TransactionType",
                 foreign_key: :amazon_transaction_type_id
      belongs_to :amazon_marketplace, class_name: "Amazon::Marketplace",
                 foreign_key: :amazon_marketplace_id
      belongs_to :amazon_fulfillment, class_name: "Amazon::Fulfillment",
                 foreign_key: :amazon_fulfillment_id
      belongs_to :amazon_tax_collection_model, class_name: "Amazon::TaxCollectionModel",
                 foreign_key: :amazon_tax_collection_model_id

      class << self
        def table_name
          "#{Amazon::CustomTransactions.table_name_prefix}all_time"
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
