module Amazon
  class TransactionType < ApplicationRecord
    TYPE_ORDER = "Order".freeze
    TYPE_REFUND = "Refund".freeze

    def order?
      true if name == ::Amazon::TransactionType::TYPE_ORDER
    end

    def refund?
      true if name == ::Amazon::TransactionType::TYPE_REFUND
    end
  end
end
