class AccountPolicy < ApplicationPolicy
  def create?
    user
  end
end
