module Admin
  class InvitationsController < ApplicationController
    layout "slate"

    skip_before_action :authenticate_user, :authenticate_collaborator, :affirm_collaborator
    skip_after_action :verify_authorized

    def show
      @collaborator = Collaborator.find_by(token: params[:id])
      verify_collaborator
    end

    private

    def verify_collaborator
      if @collaborator
        redirect_to dashboard_path(script_name: "/#{@collaborator.account.id}") if @collaborator.invite_accepted?
      else
        render template: "admin/accounts/not_found"
      end
    end
  end
end
