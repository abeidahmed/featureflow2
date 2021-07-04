class User
  class SignInFormComponent < ApplicationComponent
    def initialize(button_text: nil, **options)
      @button_text = button_text.presence || "Sign in"
      @options = options
    end
  end
end
