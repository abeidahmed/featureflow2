class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.last
    UserMailer.with(user: user, sgid: user.id).password_reset
  end
end
