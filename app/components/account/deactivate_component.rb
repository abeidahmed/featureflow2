class Account
  class DeactivateComponent < ApplicationComponent
    def render?
      Current.account.active?
    end
  end
end
