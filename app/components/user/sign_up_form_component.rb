class User
  class SignUpFormComponent < ApplicationComponent
    def initialize(button_text: nil, **options)
      @button_text = button_text.presence || "Let's get started"
      @options = options
    end
  end
end
