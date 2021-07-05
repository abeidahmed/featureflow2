class User
  class SignInFormComponent < ApplicationComponent
    def initialize(button_text: nil, return_url: nil, **options)
      @button_text = button_text.presence || "Sign in"
      @return_url = return_url
      @options = options
    end
  end
end
