module Admin
  class CollaboratorsController < ApplicationController
    def create
      authorize Collaborator.new
      @collaborator = CollaboratorInviteForm.new(collaborator_params)

      if @collaborator.invite
        respond_to do |format|
          format.html { redirect_to setting_collaborators_path }
          format.turbo_stream
        end
      else
        render json: { errors: @collaborator.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @collaborator = Collaborator.find(params[:id])
      authorize @collaborator
      return head :forbidden if @collaborator.unrevokable?

      @collaborator.destroy
      respond_to do |format|
        format.html { redirect_to accounts_path(script_name: nil) }
        format.turbo_stream
      end
    end

    private

    def collaborator_params
      params.require(:collaborator).permit(:name, :email, :role)
    end
  end
end
