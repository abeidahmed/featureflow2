module Features
  module SessionsHelper
    def sign_in(user = nil)
      user ||= create(:user)
      visit new_session_path
      fill_in "Email address", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign"
    end

    def switch_account(account)
      Capybara.app_host = "http://example.com/#{account&.id}"
    end
  end
end
