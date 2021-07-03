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

      namespace "settings", as: :setting do
        root to: "general_settings#index"

        resource :domains, only: %i[edit]
        resources :collaborators, only: %i[index]
        resources :billings, only: %i[index]
      end
    end
  end
end
