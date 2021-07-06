class CollaboratorPolicy < ApplicationPolicy
  def create?
    user.invite_accepted?(record.account) && user.account_owner?(record.account)
  end

  def destroy?
    return false if user.invite_pending?(record.account)

    current_user? || user.account_owner?(record.account)
  end

  def rolify?
    return false if sole_owner_demoting_itself?

    create?
  end

  class Scope < Scope
    def resolve
      scope.all if user.invite_accepted?(Current.account)
    end
  end

  private

  def sole_owner_demoting_itself?
    record.account.owners_count == 1 && current_user?
  end

  def current_user?
    user == record.user
  end
end
