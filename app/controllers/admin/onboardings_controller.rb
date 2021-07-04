module Admin
  class OnboardingsController < ApplicationController
    layout "slate"

    skip_before_action :authenticate_collaborator, :affirm_collaborator

    def new
      @account = Account.new
      authorize @account
    end
  end
end
