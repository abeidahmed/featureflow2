class AppSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && request.subdomain == "app"
  end
end

Rails.application.routes.draw do
  constraints AppSubdomainConstraint do
    resources :users, only: %i[create]
    resources :sessions, only: %i[create]
  end
end
