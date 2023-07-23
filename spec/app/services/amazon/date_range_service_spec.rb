describe Amazon::DateRangeService do
  context :call do
    before { Timecop.freeze(Time.local(2020)) }
    after { Timecop.return }

    context :today do
      Given(:date_range) { "today" }
      Given(:expected_results) { { start_date: Time.now.beginning_of_day, end_date: Time.now.end_of_day } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :yesterday do
      Given(:date_range) { "yesterday" }
      Given(:expected_results) { { start_date: 1.day.ago.beginning_of_day, end_date: 1.day.ago.end_of_day } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :last_thirty_days do
      Given(:date_range) { "last_thirty_days" }
      Given(:expected_results) { { start_date: 30.days.ago.beginning_of_day, end_date: Time.now.end_of_day } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :previous_thirty_days do
      Given(:date_range) { "previous_thirty_days" }
      Given(:expected_results) { { start_date: 60.days.ago.beginning_of_day, end_date: 30.days.ago.beginning_of_day } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :this_month do
      Given(:date_range) { "this_month" }
      Given(:expected_results) { { start_date: Time.now.beginning_of_month, end_date: Time.now.end_of_month } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :last_month do
      Given(:date_range) { "last_month" }
      Given(:expected_results) { { start_date: 1.month.ago.beginning_of_month, end_date: 1.month.ago.end_of_month } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :month_before_last do
      Given(:date_range) { "month_before_last" }
      Given(:expected_results) { { start_date: 2.months.ago.beginning_of_month, end_date: 2.months.ago.end_of_month } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :last_three_months do
      Given(:date_range) { "last_three_months" }
      Given(:expected_results) { { start_date: 3.months.ago, end_date: Time.now } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :previous_three_months do
      Given(:date_range) { "previous_three_months" }
      Given(:expected_results) { { start_date: 6.months.ago, end_date: 3.months.ago } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :last_six_months do
      Given(:date_range) { "last_six_months" }
      Given(:expected_results) { { start_date: 6.months.ago, end_date: Time.now } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :previous_six_months do
      Given(:date_range) { "previous_six_months" }
      Given(:expected_results) { { start_date: 12.months.ago, end_date: 6.months.ago } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :this_year do
      Given(:date_range) { "this_year" }
      Given(:expected_results) { { start_date: Time.now.beginning_of_year, end_date: Time.now } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :last_year do
      Given(:date_range) { "last_year" }
      Given(:expected_results) { { start_date: 1.year.ago, end_date: Time.now } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end

    context :all_time do
      Given(:date_range) { "all_time" }
      Given(:expected_results) { { start_date: Time.at(0), end_date: Time.now } }

      When(:results) { Amazon::DateRangeService.new(date_range:).call }

      Then { expect(results.start_date).to eq(expected_results.try(:[], :start_date)) }
      And { expect(results.end_date).to eq(expected_results.try(:[], :end_date)) }
    end
  end
end
