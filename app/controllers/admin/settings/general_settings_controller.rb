module Admin
  module Settings
    class GeneralSettingsController < ApplicationController
      def index
        skip_policy_scope
      end
    end
  end
end
