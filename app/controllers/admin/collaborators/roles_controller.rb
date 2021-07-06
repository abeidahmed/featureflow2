module Admin
  module Collaborators
    class RolesController < ApplicationController
      layout false

      def show
        @collaborator = Collaborator.find(params[:collaborator_id])
        authorize @collaborator, :rolify?
      end
    end
  end
end
