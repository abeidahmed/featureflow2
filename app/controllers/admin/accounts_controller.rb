module Admin
  class AccountsController < ApplicationController
    skip_before_action :authenticate_collaborator, :affirm_collaborator, only: %i[index create]

    def index
      skip_policy_scope
      @accounts = Account.where(collaborators: Current.user)
    end

    def create
      account = Account.new(new_account_params)
      authorize account
      account.creator = Current.user

      if account.save
        account.collaborators.create!(role: "owner", joined_at: Time.zone.now, user: Current.user)
        redirect_to dashboard_path(script_name: "/#{account.id}")
      else
        render json: { errors: account.errors }, status: :unprocessable_entity
      end
    end

    def update
      authorize Current.account

      if Current.account.update(edit_account_params)
        respond_to do |format|
          format.html { redirect_back fallback_location: setting_root_path }
          format.turbo_stream
        end
      else
        render json: { errors: Current.account.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize Current.account
      Current.account.destroy

      redirect_to accounts_path(script_name: nil)
    end

    private

    def new_account_params
      params.require(:account).permit(:name, :subdomain)
    end

    def edit_account_params
      params.require(:account).permit(:name, :cname)
    end
  end
end
