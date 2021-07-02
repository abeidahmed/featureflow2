Rails.application.routes.draw do
  constraints AppSubdomainConstraint do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create]
    resources :password_resets, only: %i[new create show]

    scope module: :admin do
      resources :onboardings, only: %i[new]
      resources :accounts, only: %i[create]
    end
  end
end
