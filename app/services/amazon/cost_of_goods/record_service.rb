module Amazon
  module CostOfGoods
    class RecordService < ApplicationService
      def initialize(opts = {})
        @amazon_marketplace_id = opts.fetch(:amazon_marketplace_id)
        @amazon_cost_of_good_id = opts.fetch(:amazon_cost_of_good_id)
        @user_id = opts.fetch(:user_id)
        @sku = opts.fetch(:sku)
        @amount = opts.fetch(:amount)
        @date_time = opts.fetch(:date_time)
      end

      attr_accessor :amazon_marketplace_id, :amazon_cost_of_good_id, :user_id, :sku, :amount, :date_time

      def call
        process
      end

      private

      def process
        OpenStruct.new(success?: false, error?: true, message: "marketplace does not exist") if amazon_marketplace.nil?

        record

        OpenStruct.new(success?: true, error?: false)
      end

      def record
        cost_of_good.update(amazon_marketplace:, user_id:, sku:, amount:, date_time:)
      end

      def cost_of_good
        @cost_of_good ||= Amazon::CostOfGood.create_or_find_by amazon_cost_of_good_id:
      end

      def amazon_marketplace
        @amazon_marketplace ||= Amazon::Marketplace.where(amazon_marketplace_id:).first
      end
    end
  end
end
