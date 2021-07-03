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

  def show
    verify_resetable_user
  end

  def edit
    verify_resetable_user
  end

  def update
    user = User.find_signed!(params[:id], purpose: :password_reset)

    if user_params[:password].length < 6
      user.errors.add(:password, "is too short (min. 6 characters)")
      render json: { errors: user.errors }, status: :unprocessable_entity
    elsif user.update(user_params)
      redirect_to new_session_path
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def verify_resetable_user
    @user = User.find_signed(params[:id], purpose: :password_reset)
    redirect_to new_password_reset_path unless @user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
