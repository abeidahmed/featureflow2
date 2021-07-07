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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
