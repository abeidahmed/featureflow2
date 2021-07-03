class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @sgid = params[:sgid]

    mail to: @user.email, subject: "Password reset instruction"
  end
end
