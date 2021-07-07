class Account
  class ActivateComponent < ApplicationComponent
    def render?
      Current.account.inactive?
    end
  end
end
