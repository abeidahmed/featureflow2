Rails.application.routes.draw do
  constraints AppSubdomainConstraint do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[create]
  end
end
