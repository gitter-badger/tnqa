class QuestionPolicy < ApplicationPolicy

	def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    record.user == user
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
