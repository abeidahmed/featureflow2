class SubheadComponent < ApplicationComponent
  renders_one :heading, lambda { |variant: nil, **options|
    options[:tag] ||= :h2
    options[:classes] = class_names(
      options[:classes],
      "subhead-heading",
      "subhead-heading--danger": variant == "danger",
    )

    ApplicationComponent.new(**options)
  }

  renders_one :description, lambda { |**options|
    options[:tag] ||= :div
    options[:classes] = class_names(
      options[:classes],
      "subhead-description",
    )

    ApplicationComponent.new(**options)
  }

  def initialize(**options)
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      options[:classes],
      "subhead",
    )
  end

  def render?
    heading.present?
  end
end
