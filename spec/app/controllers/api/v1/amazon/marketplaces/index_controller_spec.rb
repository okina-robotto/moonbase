describe Api::V1::Amazon::Marketplaces::IndexController, type: :controller do
  context "index" do
    Given { create(:amazon_marketplace) }
    Given(:token) { ENV["API_TOKEN"] }

    When { request.headers.merge!({ "Authorization" => "Token #{token}" }) }
    When { get :index, format: "json"  }

    Then { expect(response.code.to_i).to eq(200) }
    And { expect(response.body.empty?).to be_falsey }
  end
end
