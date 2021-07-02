module Form
  class ErrorComponent < ApplicationComponent
    def initialize(error_field:, **options)
      @options = options

      @options[:tag] ||= :p
      @options[:"data-hotwire-target"] = "errorContainer"
      @options[:"data-form-error"] = error_field
      @options[:classes] = class_names(
        options[:classes],
        "mt-1",
        "text-red",
        "h6",
      )
    end

    def call
      render ApplicationComponent.new(**@options)
    end
  end
end
