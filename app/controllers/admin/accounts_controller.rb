module Admin
  class AccountsController < ApplicationController
    def create
      account = Account.new(account_params)
      authorize account
      account.creator = Current.user

      if account.save
        # do
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
