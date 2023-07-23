describe Api::V1::Amazon::CostOfGoods::IndexController, type: :controller do
  context "index" do
    Given(:token) { ENV["API_TOKEN"] }
    Given(:user_id) { "ed64618d-2944-4620-b4d1-10ea746751a5" }
    Given(:amazon_marketplace) { create(:amazon_marketplace) }
    Given(:params) do
      { amazon_marketplace_id: amazon_marketplace.amazon_marketplace_id,
        amazon_cost_of_good_id: "408a3dca-69d4-4bf1-b859-e4a67f50a091",
        user_id:, sku: "SOME_SKU", amount: 99.97, date_time: 1605333689 }
    end

    When { request.headers.merge!({ "Authorization" => "Token #{token}" }) }
    When { put :index, params:, format: "json" }

    Then { expect(response.code.to_i).to eq(200) }
    And { expect(Amazon::CostOfGood.where(user_id:).count).to eq(1) }
  end
end
