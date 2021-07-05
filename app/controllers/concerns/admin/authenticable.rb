module Admin
  module Authenticable
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user, :authenticate_collaborator, :affirm_collaborator
    end

    private

    def authenticate_user
      redirect_to new_session_path(script_name: nil) unless Current.user
    end

    def authenticate_collaborator
      return if Current.user.collaborator_exists?(Current.account)

      redirect_to new_session_path(script_name: nil)
    end

    def affirm_collaborator
      return if Current.user.invite_accepted?(Current.account)

      redirect_to invitation_path(invitation_token, script_name: "/#{Current.account}")
    end

    def invitation_token
      Current.user.find_collaborator(Current.account).token
    end
  end
end
