module Admin
  class OnboardingsController < ApplicationController
    def new
      @account = Account.new
      authorize @account
    end
  end
end
