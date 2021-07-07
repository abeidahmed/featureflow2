module Admin
  module Accounts
    class CollaboratorsController < ApplicationController
      layout false

      def index
        @collaborators = policy_scope(Collaborator)
          .includes(:user)
          .alphabetically
          .search(params[:query])
          .limit(Collaborator::DEFAULT_LIMIT)
      end
    end
  end
end
