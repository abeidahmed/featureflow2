module Admin
  module Collaborators
    class RemovalsController < ApplicationController
      layout false

      def show
        @collaborator = Collaborator.find(params[:collaborator_id])
        authorize @collaborator, :destroy?
      end
    end
  end
end
