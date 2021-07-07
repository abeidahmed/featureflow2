class PaginationComponent < ApplicationComponent
  def initialize(records:, **options)
    @records = records
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      options[:classes],
      "mt-6 flex justify-center",
    )
  end

  def call
    render ApplicationComponent.new(**@options) do
      pagy_nav(@records).html_safe # rubocop:disable Rails/OutputSafety
    end
  end

  def render?
    @records.pages > 1
  end
end
