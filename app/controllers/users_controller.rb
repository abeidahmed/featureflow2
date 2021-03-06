class UsersController < ApplicationController
  layout "slate"

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      sign_in(user)
      redirect_to new_onboarding_path
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
