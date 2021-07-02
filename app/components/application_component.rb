class ApplicationComponent < ViewComponent::Base
  include ApplicationHelper
  include ClassNamesHelper

  def initialize(tag: nil, classes: nil, **options)
    @tag = tag
    @classes = classes
    @options = options
  end

  def call
    content_tag(@tag, content, class: @classes, **@options) if @tag
  end
end
