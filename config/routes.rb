Rails.application.routes.draw do
  constraints AppSubdomainConstraint do
    resources :users, only: %i[create]
    resources :sessions, only: %i[create]
  end
end
