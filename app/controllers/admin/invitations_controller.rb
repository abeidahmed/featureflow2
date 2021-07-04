module Admin
  class InvitationsController < ApplicationController
    layout "slate"

    skip_before_action :authenticate_user

    def show
      skip_authorization
      @collaborator = Collaborator.find_by(token: params[:id])

      if @collaborator
        redirect_to dashboard_path(script_name: "/#{@collaborator.account.id}") if @collaborator.invite_accepted?
      else
        render template: "admin/accounts/not_found"
      end
    end
  end
end
