module Admin
  class OnboardingsController < ApplicationController
    layout "slate"

    def new
      @account = Account.new
      authorize @account
    end
  end
end
