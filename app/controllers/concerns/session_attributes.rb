module SessionAttributes
  def sign_in(user)
    cookies.signed.permanent[:auth_token] = user.auth_token
  end

  def signout_user
    cookies.delete(:auth_token) if cookies[:auth_token]
  end

  # used by pundit
  def current_user
    Current.user
  end
end
