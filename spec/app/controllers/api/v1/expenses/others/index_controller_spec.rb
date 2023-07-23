describe Api::V1::Expenses::Others::IndexController, type: :controller do
  context "index" do
    Given(:token) { ENV["API_TOKEN"] }
    Given(:user_id) { "ed64618d-2944-4620-b4d1-10ea746751a5" }
    Given(:currency_exchange_rate) { create(:currency_exchange_rate) }
    Given(:params) do
      { expenses_other_id: "408a3dca-69d4-4bf1-b859-e4a67f50a091",
        currency_exchange_rate_id: currency_exchange_rate.currency_exchange_rate_id,
        user_id:, amount: 99.97, date_time: 1605333689 }
    end

    When { request.headers.merge!({ "Authorization" => "Token #{token}" }) }
    When { put :index, params:, format: "json" }

    Then { expect(response.code.to_i).to eq(200) }
    And { expect(Expenses::Other.where(user_id:).count).to eq(1) }
  end
end
