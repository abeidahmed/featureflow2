class CollaboratorPolicy < ApplicationPolicy
  def create?
    user.invite_accepted?(record.account) && user.account_owner?(record.account)
  end

  def destroy?
    return false if user.invite_pending?(record.account)

    user == record.user || user.account_owner?(record.account)
  end

  class Scope < Scope
    def resolve
      scope.all if user.invite_accepted?(Current.account)
    end
  end
end
