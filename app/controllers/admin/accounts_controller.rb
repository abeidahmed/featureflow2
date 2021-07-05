module Admin
  class AccountsController < ApplicationController
    skip_before_action :authenticate_collaborator, :affirm_collaborator

    def index
      skip_policy_scope
    end

    def create
      account = Account.new(account_params)
      authorize account
      account.creator = Current.user

      if account.save
        account.collaborators.create!(role: "owner", joined_at: Time.zone.now, user: Current.user)
        redirect_to dashboard_path(script_name: "/#{account.id}")
      else
        render json: { errors: account.errors }, status: :unprocessable_entity
      end
    end

    private

    def account_params
      params.require(:account).permit(:name, :subdomain)
    end
  end
end
