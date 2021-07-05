module Admin
  class FeaturesController < ApplicationController
    def index
      skip_policy_scope
    end
  end
end
