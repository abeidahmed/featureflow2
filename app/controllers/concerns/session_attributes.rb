module SessionAttributes
  def sign_in(user)
    cookies.signed.permanent[:auth_token] = user.auth_token
  end

  def signout_user
    cookies.delete(:auth_token) if cookies[:auth_token]
  end
end
