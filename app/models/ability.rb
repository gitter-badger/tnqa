class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, [Question, Answer, Comment]
        can :update, [Question, Answer, Comment], user_id: user.id
        can :destroy, [Question, Answer, Comment], user_id: user.id
      end
    else
      can :read, [Question, Answer, Comment]
    end
  end
end

# class Ability
#   include CanCan::Ability

#   def initialize(user)
#     if user
#       user.admin? ? admin_abilities : user_abilities(user)
#     else
#       guest_abilities
#     end
#   end

#   def admin_abilities
#       can :manage, :all
#   end

#   def user_abilities(user)
#     can :read, :all
#     can :create, [Question, Answer, Comment]
#     can :update, [Question, Answer, Comment], user_id: user.id
#     can :destroy, [Question, Answer, Comment], user_id: user.id
#  end

#   def guest_abilities
#     can :read, [Question, Answer, Comment]
#   end
# end
