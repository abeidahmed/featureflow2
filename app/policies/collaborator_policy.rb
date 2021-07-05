class CollaboratorPolicy < ApplicationPolicy
  def create?
    user.invite_accepted?(record.account) && user.account_owner?(record.account)
  end

  class Scope < Scope
    def resolve
      scope.all if user.invite_accepted?(Current.account)
    end
  end
end
