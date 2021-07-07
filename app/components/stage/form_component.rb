class Stage
  class FormComponent < ApplicationComponent
    DEFAULT_PALETTE = %w[
      #b60205 #d93f0b #ca8A04 #0e8a16
      #006b75 #1d76db #0052cc #5319e7
    ].freeze

    def initialize(**options)
      @options = options
    end

    def box_title
      if @options[:model]&.persisted?
        "Edit this stage"
      else
        "Add a new stage"
      end
    end
  end
end
