Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq/cron/web"
  mount Sidekiq::Web => "/sidekiq"

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == "lyticaa" && password == ENV["SIDEKIQ_ADMIN_PASSWORD"]
  end

  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"

  namespace :api do
    namespace :status do
      get "/", to: "index#index"
    end

    namespace :v1 do
      namespace :amazon do
        put "/:amazon_marketplace_id/cost_of_goods/:amazon_cost_of_good_id", to: "cost_of_goods/index#index"

        namespace :marketplaces do
          get "/", to: "index#index"
        end

        namespace :reports do
          namespace :ingest do
            get "/:user_id", to: "index#index"
          end
        end
      end

      namespace :currency do
        namespace :exchange_rates do
          get "/", to: "index#index"
        end
      end

      namespace :expenses do
        namespace :others do
          put "/:expenses_other_id", to: "index#index"
        end
      end
    end
  end

  root "api/status/index#index"
end
