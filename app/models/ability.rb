class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  private

  def user_abilities
    can :read, Lot
    can :create, Bet
    can :manage, :profile
  end

  def guest_abilities
    can :read, Lot
  end

  def admin_abilities
    can :manage, :all
  end
end
