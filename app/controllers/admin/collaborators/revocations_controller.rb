module Admin
  module Collaborators
    class RevocationsController < ApplicationController
      layout "slate"

      def show
        @collaborator = Collaborator.find(params[:collaborator_id])
        authorize @collaborator, :destroy?

        render template: "admin/collaborators/revocations/not_allowed" if @collaborator.unrevokable?
      end
    end
  end
end
