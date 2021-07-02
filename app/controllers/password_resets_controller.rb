class PasswordResetsController < ApplicationController
  layout "slate"

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user
      # do
    else
      render json: { errors: { invalid: ["email address"] } }, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end
end
