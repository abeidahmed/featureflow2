class User
  class SignInFormComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end
  end
end
