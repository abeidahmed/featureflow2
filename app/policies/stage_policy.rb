class StagePolicy < ApplicationPolicy
  def create?
    user.invite_accepted?(record)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
