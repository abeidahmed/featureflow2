module Admin
  module Invitations
    class RsvpsController < InvitationsController
      def new
        set_collaborator
        verify_collaborator
      end

      def create
        set_collaborator!

        if valid_collaborator?
          persist_collaborator
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

      def update
        set_collaborator!

        auth = Authentication.new(params)
        if auth.authenticated?
          begin
            persist_collaborator(auth.user) # TODO: also delete the previous user?
            sign_in(@collaborator.user)
            redirect_to dashboard_path
          rescue ActiveRecord::RecordInvalid => _e
            @collaborator.errors.add(:invalid, "login attempt. User is already in the account")
            render json: { errors: @collaborator.errors }, status: :unprocessable_entity
          end
        else
          render json: { errors: { invalid: ["credentials"] } }, status: :unprocessable_entity
        end
      end

      private

      def set_collaborator
        @collaborator = Collaborator.find_by(token: params[:invitation_id])
      end

      def set_collaborator!
        @collaborator = Collaborator.find_by!(token: params[:invitation_id])
        raise ActiveRecord::RecordNotFound if @collaborator.invite_accepted?
      end

      def collaborator_params
        params.require(:collaborator).permit(:name, :email, :password)
      end

      def valid_collaborator?
        @collaborator.user.valid_password?(collaborator_params[:password]) &&
          @collaborator.user.update(collaborator_params)
      end

      def persist_collaborator(user = nil)
        @collaborator.transaction do
          @collaborator.user = user if user
          @collaborator.joined_at = Time.zone.now
          @collaborator.regenerate_token # this should be at the last for update to happen in one query
        end
      end
    end
  end
end
