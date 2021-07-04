module Admin
  class CollaboratorsController < ApplicationController
    def create
      authorize Collaborator.new
      @collaborator = CollaboratorInviteForm.new(collaborator_params)

      if @collaborator.invite
        # do
      else
        render json: { errors: @collaborator.errors }, status: :unprocessable_entity
      end
    end

    private

    def collaborator_params
      params.require(:collaborator).permit(:name, :email, :role)
    end
  end
end
