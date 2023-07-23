module Amazon
  class CostOfGood < ApplicationRecord
    include Lyticaa::Uuid

    belongs_to :amazon_marketplace, class_name: "Amazon::Marketplace",
               foreign_key: :amazon_marketplace_id

    validates_presence_of :amazon_cost_of_good_id
    validates_presence_of :user_id
    validates_presence_of :sku
    validates_presence_of :amount
    validates_presence_of :date_time

    validates_format_of :amazon_cost_of_good_id, with: VALID_UUID
    validates_format_of :user_id, with: VALID_UUID
  end
end
