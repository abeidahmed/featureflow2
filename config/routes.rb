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
      resources :accounts, only: %i[index create]

      resource :accounts, only: %i[update destroy], as: :account do
        resource :statuses, only: %i[update], module: :accounts
      end

      resources :collaborators, only: %i[create update destroy] do
        resource :revocations, only: %i[show], module: :collaborators
        resource :removals, only: %i[show], module: :collaborators
        resource :roles, only: %i[show], module: :collaborators
      end

      resources :invitations, only: %i[show] do
        resource :rsvp, only: %i[new create edit update], module: :invitations
      end

      namespace "settings", as: :setting do
        root to: "general_settings#index"

        resource :domains, only: %i[edit]
        resources :collaborators, only: %i[index]
        resources :billings, only: %i[index]
      end
    end
  end
end
