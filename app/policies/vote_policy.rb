class VotePolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    record.user == user
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
