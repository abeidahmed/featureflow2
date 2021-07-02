module Template
  class SlateComponent < ApplicationComponent
    renders_one :heading, lambda { |**options|
      options[:tag] ||= :h1
      options[:classes] = class_names(
        options[:classes],
        "h2",
        "text-center",
      )

      ApplicationComponent.new(**options)
    }

    renders_one :body, lambda { |**options|
      options[:tag] ||= :div
      options[:classes] = class_names(
        options[:classes],
        "box",
        "box--mktg",
        "mt-6",
        "shadow-lg",
        "max-w-md",
        "w-full",
        "mx-auto",
      )

      ApplicationComponent.new(**options)
    }

    renders_one :footer, lambda { |**options|
      options[:tag] ||= :div
      options[:classes] = class_names(
        options[:classes],
        "mt-10",
      )

      ApplicationComponent.new(**options)
    }

    def initialize(**options)
      @options = options
      @options[:tag] ||= :div
      @options[:classes] = class_names(
        options[:classes],
        "flex",
        "justify-center",
        "main--slate",
      )
    end
  end
end
