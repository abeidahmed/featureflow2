Rails.application.routes.draw do
  constraints AppSubdomainConstraint do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create]

    scope module: :admin do
      resources :onboardings, only: %i[new]
    end
  end
end
