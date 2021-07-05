class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @sgid = params[:sgid]
    @return_url = params[:return_url]

    mail to: @user.email, subject: "Password reset instruction"
  end
end
