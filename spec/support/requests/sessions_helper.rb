module Requests
  module SessionsHelper
    def sign_in(user = nil)
      user ||= create(:user)

      signed_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      signed_cookies.signed[:auth_token] = user.auth_token
      cookies[:auth_token] = signed_cookies[:auth_token]
    end

    def signed_cookie
      ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash).signed
    end

    def switch_account(account)
      host! "example.com/#{account.id}"
    end
  end
end
