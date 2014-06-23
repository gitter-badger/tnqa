class UserPolicy < ApplicationPolicy

	def index?
		true
	end
	
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
