class PasswordResetsController < ApplicationController
  layout "slate"

  def new; end

  def create
    user = User.find_by(email: user_email)

    if user
      sgid = user.signed_id(expires_in: 2.hours, purpose: :password_reset)
      UserMailer.with(user: user, sgid: sgid).password_reset.deliver_later
      redirect_to password_reset_path(sgid)
    else
      render json: { errors: { invalid: ["email address"] } }, status: :unprocessable_entity
    end
  end

  def show
    verify_resetable_user
  end

  def edit
    verify_resetable_user
  end

  def update
    user = PasswordResetForm.new(user_params.merge(id: params[:id]))

    if user.save
      redirect_to new_session_path
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def verify_resetable_user
    @user = User.find_signed(params[:id], purpose: :password_reset)
    render template: "password_resets/not_found" unless @user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_email
    params.dig(:user, :email).downcase
  end
end
