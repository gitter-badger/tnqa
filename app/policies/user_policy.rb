class UserPolicy < ApplicationPolicy

	def index?
		true
	end

	def upvote?
		user.reputation >= 15
	end

	def downvote?
		user.reputation >= 125
	end
	
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
