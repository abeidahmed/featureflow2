class Stage
  class ListComponent < ApplicationComponent
    with_collection_parameter :stage

    def initialize(stage:)
      @stage = stage
    end
  end
end
