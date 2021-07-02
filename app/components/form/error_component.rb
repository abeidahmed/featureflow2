module Form
  class ErrorComponent < ApplicationComponent
    attr_reader :error_field

    def initialize(error_field:)
      @error_field = error_field
    end
  end
end
