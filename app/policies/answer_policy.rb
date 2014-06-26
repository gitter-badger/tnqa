class AnswerPolicy < ApplicationPolicy

  def create?
    user.present? && user.reputation >= 50
  end

  def update?
    record.user == user || user.reputation >= 2000
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
