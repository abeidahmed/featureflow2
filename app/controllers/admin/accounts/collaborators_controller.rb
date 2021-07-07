module Admin
  module Accounts
    class CollaboratorsController < ApplicationController
      layout false

      def index
        @collaborators = policy_scope(Collaborator)
          .includes(:user)
          .alphabetically
          .search(params[:query])
      end
    end
  end
end
