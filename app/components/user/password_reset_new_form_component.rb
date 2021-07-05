class User
  class PasswordResetNewFormComponent < ApplicationComponent
    def initialize(return_url: nil, **options)
      @return_url = return_url
      @options = options
    end
  end
end
