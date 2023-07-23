module Amazon
  class DateRangeService < ApplicationService
    def initialize(opts = {})
      @date_range = opts.fetch(:date_range)
    end

    attr_accessor :date_range

    def call
      start_date, end_date = send(date_range)

      OpenStruct.new(success?: true, start_date:, end_date:)
    end

    private

    def today
      [Time.now.beginning_of_day, Time.now.end_of_day]
    end

    def yesterday
      [1.day.ago.beginning_of_day, 1.day.ago.end_of_day]
    end

    def last_thirty_days
      [30.days.ago.beginning_of_day, Time.now.end_of_day]
    end

    def previous_thirty_days
      [60.days.ago.beginning_of_day, 30.days.ago.beginning_of_day]
    end

    def this_month
      [Time.now.beginning_of_month, Time.now.end_of_month]
    end

    def last_month
      [1.month.ago.beginning_of_month, 1.month.ago.end_of_month]
    end

    def month_before_last
      [2.months.ago.beginning_of_month, 2.months.ago.end_of_month]
    end

    def last_three_months
      [3.months.ago, Time.now]
    end

    def previous_three_months
      [6.months.ago, 3.months.ago]
    end

    def last_six_months
      [6.months.ago, Time.now]
    end

    def previous_six_months
      [12.months.ago, 6.months.ago]
    end

    def this_year
      [Time.now.beginning_of_year, Time.now]
    end

    def last_year
      [1.year.ago, Time.now]
    end

    def all_time
      [Time.at(0), Time.now]
    end
  end
end
