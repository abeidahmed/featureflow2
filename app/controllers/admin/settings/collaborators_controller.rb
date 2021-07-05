module Admin
  module Settings
    class CollaboratorsController < ApplicationController
      def index
        @collaborators = policy_scope(Collaborator).includes(:user)
      end
    end
  end
end
