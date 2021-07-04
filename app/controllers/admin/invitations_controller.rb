module Admin
  class InvitationsController < ApplicationController
    layout "slate"

    skip_before_action :authenticate_user

    def show
      skip_authorization
    end
  end
end
