module Admin
  module Accounts
    class StatusesController < ApplicationController
      def update
        authorize Current.account

        if Current.account.active?
          Current.account.inactive!
          flash[:success] = { message: "Account deactivated" }
        else
          Current.account.active!
          flash[:success] = { message: "Account activated" }
        end

        redirect_to setting_root_path
      end
    end
  end
end
