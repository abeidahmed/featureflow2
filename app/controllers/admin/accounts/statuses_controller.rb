module Admin
  module Accounts
    class StatusesController < ApplicationController
      def update
        authorize Current.account

        if Current.account.active?
          Current.account.inactive!
        else
          Current.account.active!
        end

        redirect_to setting_root_path, success: { message: "Account deactivated" }
      end
    end
  end
end
