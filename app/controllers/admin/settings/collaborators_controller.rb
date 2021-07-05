module Admin
  module Settings
    class CollaboratorsController < ApplicationController
      def index
        @collaborators = policy_scope(Collaborator).includes(:user).alphabetically
      end
    end
  end
end
