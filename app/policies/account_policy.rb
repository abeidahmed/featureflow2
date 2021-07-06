class AccountPolicy < ApplicationPolicy
  def create?
    user
  end

  def update?
    user.invite_accepted?(record) && user.account_owner?(record)
  end

  def destroy?
    update?
  end
end
