module Admin
  module Invitations
    class RsvpsController < InvitationsController
      def new
        set_collaborator
        verify_collaborator
      end

      def create
        set_collaborator!
        raise ActiveRecord::RecordNotFound if @collaborator.invite_accepted?

        if valid_collaborator?
          @collaborator.update(joined_at: Time.zone.now)
          @collaborator.regenerate_token
          sign_in(@collaborator.user)
          redirect_to dashboard_path
        else
          render json: { errors: @collaborator.user.errors }, status: :unprocessable_entity
        end
      end

      def edit
        set_collaborator
        verify_collaborator
      end

      private

      def set_collaborator
        @collaborator = Collaborator.find_by(token: params[:invitation_id])
      end

      def set_collaborator!
        @collaborator = Collaborator.find_by!(token: params[:invitation_id])
      end

      def collaborator_params
        params.require(:collaborator).permit(:name, :email, :password)
      end

      def valid_collaborator?
        @collaborator.user.valid_password?(collaborator_params[:password]) &&
          @collaborator.user.update(collaborator_params)
      end
    end
  end
end
