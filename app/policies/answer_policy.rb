class AnswerPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def destroy?
    update?
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
