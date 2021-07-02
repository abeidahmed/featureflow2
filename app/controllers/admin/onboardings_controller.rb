module Admin
  class OnboardingsController < ApplicationController
    def new
      @account = Account.new
    end
  end
end
