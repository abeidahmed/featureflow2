module Admin
  module Invitations
    class RsvpsController < InvitationsController
      def new
        set_collaborator
        verify_collaborator
      end

      def edit
        set_collaborator
        verify_collaborator
      end

      private

      def set_collaborator
        @collaborator = Collaborator.find_by(token: params[:invitation_id])
      end
    end
  end
end
