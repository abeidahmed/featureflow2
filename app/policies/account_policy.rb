class AccountPolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user.invite_accepted?(record) && user.account_owner?(record)
  end
end
