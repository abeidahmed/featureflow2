class PasswordResetsController < ApplicationController
  layout "slate"

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      UserMailer.with(user: user, sgid: sgid).password_reset.deliver_later

      redirect_to password_reset_path(sgid)
    else
      render json: { errors: { invalid: ["email address"] } }, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end
end
