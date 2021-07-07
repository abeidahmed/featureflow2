module Admin
  module Settings
    class CollaboratorsController < ApplicationController
      def index
        @pagy, @collaborators = pagy(
          policy_scope(Collaborator)
          .includes(:user)
          .alphabetically, items: Collaborator::DEFAULT_LIMIT
        )
      end
    end
  end
end
