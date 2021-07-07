class PopoverComponent < ApplicationComponent
  DEFAULT_POSITION = :top_left

  POSITIONS = {
    bottom: "popover-message--bottom",
    bottom_right: "popover-message--bottom-right",
    bottom_left: "popover-message--bottom-left",
    left: "popover-message--left",
    left_bottom: "popover-message--left-bottom",
    left_top: "popover-message--left-top",
    right: "popover-message--right",
    right_bottom: "popover-message--right-bottom",
    right_top: "popover-message--right-top",
    top_left: "popover-message--top-left",
    top_right: "popover-message--top-right"
  }.freeze

  renders_one :body, lambda { |caret: DEFAULT_POSITION, **options|
    options[:tag] ||= :div
    options[:classes] = class_names(
      options[:classes],
      "popover-message box p-3 shadow-lg mt-1",
      POSITIONS[fetch_or_fallback(POSITIONS.keys, given_value: caret, fallback: DEFAULT_POSITION)],
    )

    ApplicationComponent.new(**options)
  }

  def initialize(**options)
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      options[:classes],
      "popover",
    )
  end
end
