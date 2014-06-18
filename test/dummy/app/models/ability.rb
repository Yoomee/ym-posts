# Don't delete comments! They are used in gems for adding abilities
class Ability
  
  include CanCan::Ability
  
  def initialize(user)
    
    # open ability
    
    if user.try(:admin?)
      can :manage, :all      
      # admin ability
    elsif user
      # user ability
      can [:read, :create, :file], Post
      can [:update, :destroy], Post, :user_id => user.id
      can [:create], Comment
      can :index, Notification
      can :manage, User, :id => user.id      
    end
    
  end
  
end
