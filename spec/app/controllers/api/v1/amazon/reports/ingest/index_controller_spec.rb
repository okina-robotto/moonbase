describe Api::V1::Amazon::Reports::Ingest::IndexController, type: :controller do
  context "index" do
    Given(:token) { ENV["API_TOKEN"] }
    Given(:user_id) { "ed64618d-2944-4620-b4d1-10ea746751a5" }
    Given(:params) { { user_id: } }

    When { request.headers.merge!({ "Authorization" => "Token #{token}" }) }
    Sidekiq::Testing.inline! do
      When { get :index, params:, format: "json"  }
    end

    Then { expect(response.code.to_i).to eq(200) }
    And { expect(::Amazon::Reports::Ingest::ProcessJob).to have_enqueued_sidekiq_job user_id }
  end
end
