module Amazon
  module Marketplaces
    class SummaryService < ApplicationService
      def call
        marketplaces
      end

      private

      def marketplaces
        Amazon::Marketplace.select(:amazon_marketplace_id, :name).all
      end
    end
  end
end
