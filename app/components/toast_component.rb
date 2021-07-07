class ToastComponent < ApplicationComponent
  ICON_TYPES = {
    success: "check",
    error: "close"
  }.freeze

  attr_reader :message, :variant

  def initialize(message:, variant: "success")
    @message = message
    @variant = variant
  end

  def flash_icon
    ICON_TYPES[variant.to_sym]
  end
end
