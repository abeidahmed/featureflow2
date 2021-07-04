class CollaboratorPolicy < ApplicationPolicy
  def create?
    user.invite_accepted?(record.account) && user.account_owner?(record.account)
  end
end
