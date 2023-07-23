module Expenses
  module Others
    class RecordService < ApplicationService
      def initialize(opts = {})
        @expenses_other_id = opts.fetch(:expenses_other_id)
        @currency_exchange_rate_id = opts.fetch(:currency_exchange_rate_id)
        @user_id = opts.fetch(:user_id)
        @amount = opts.fetch(:amount)
        @date_time = opts.fetch(:date_time)
      end

      attr_accessor :expenses_other_id, :currency_exchange_rate_id, :user_id, :amount, :date_time

      def call
        process
      end

      private

      def process
        OpenStruct.new(success?: false, error?: true, message: "exchange rate does not exist") if currency_exchange_rate.nil?

        record

        OpenStruct.new(success?: true, error?: false)
      end

      def record
        other.update(currency_exchange_rate:, user_id:, amount:, date_time:)
      end

      def other
        @other ||= Expenses::Other.create_or_find_by expenses_other_id:
      end

      def currency_exchange_rate
        @currency_exchange_rate ||= Currency::ExchangeRate.where(currency_exchange_rate_id:).first
      end
    end
  end
end
