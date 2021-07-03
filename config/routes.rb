require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"

  constraints AppSubdomainConstraint do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create]
    resources :password_resets, only: %i[new create show edit update]

    scope module: :admin do
      root to: "features#index", as: :dashboard

      resources :onboardings, only: %i[new]
      resources :accounts, only: %i[create]
    end
  end
end
