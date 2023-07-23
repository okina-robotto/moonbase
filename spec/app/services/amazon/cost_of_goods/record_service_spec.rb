describe Amazon::CostOfGoods::RecordService do
  context :call do
    Given(:user_id) { "ad6aa243-b18f-4210-b911-6afd57697ebe" }
    Given(:amazon_marketplace) { create(:amazon_marketplace) }
    Given(:params) do
      { amazon_marketplace_id: amazon_marketplace.amazon_marketplace_id,
        amazon_cost_of_good_id: "8d5d44a1-5268-4ef8-85a5-f907b2920b39",
        user_id:, sku: "SOME_SKU", amount: 99.97, date_time: 1605333689 }
    end

    When(:result) do
      Amazon::CostOfGoods::RecordService.new(params).call
    end

    Then { expect(result.success?).to be_truthy }
    And { expect(Amazon::CostOfGood.where(user_id:).count).to eq(1) }
  end
end
