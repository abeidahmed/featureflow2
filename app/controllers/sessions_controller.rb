class SessionsController < ApplicationController
  layout "slate"

  def create
    auth = Authentication.new(params)

    if auth.authenticated?
      sign_in(auth.user)
      redirect_to accounts_path(script_name: nil)
    else
      render json: { errors: { invalid: ["credentials"] } }, status: :unprocessable_entity
    end
  end
end
