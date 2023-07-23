describe Expenses::Others::RecordService do
  context :call do
    Given(:user_id) { "ad6aa243-b18f-4210-b911-6afd57697ebe" }
    Given(:currency_exchange_rate) { create(:currency_exchange_rate) }
    Given(:params) do
      { expenses_other_id: "8d5d44a1-5268-4ef8-85a5-f907b2920b39",
        currency_exchange_rate_id: currency_exchange_rate.currency_exchange_rate_id,
        user_id:, amount: 99.97, date_time: 1605333689 }
    end

    When(:result) do
      Expenses::Others::RecordService.new(params).call
    end

    Then { expect(result.success?).to be_truthy }
    And { expect(Expenses::Other.where(user_id:).count).to eq(1) }
  end
end
