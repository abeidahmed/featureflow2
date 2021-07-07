class ApplicationComponent < ViewComponent::Base
  include ApplicationHelper
  include SvgHelper
  include ClassNamesHelper
  include Pundit

  def initialize(tag: nil, classes: nil, **options)
    @tag = tag
    @classes = classes
    @options = options
  end

  def call
    content_tag(@tag, content, class: @classes, **@options) if @tag
  end

  def fetch_or_fallback(allowed_values, given_value:, fallback: nil)
    if allowed_values.include?(given_value)
      given_value
    else
      fallback
    end
  end
end
