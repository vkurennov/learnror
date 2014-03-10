class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end
  end

  private

  def user_abilities(user)
    can :read, Lot
    can :create, Bet
    can :manage, :profile

    user.permissions.each do |p|
      begin
        can p.action.to_sym, p.subject.constantize, id: p.subject_id
      rescue NameError
        can p.action.to_sym, p.subject.to_sym
      end
    end
  end

  def guest_abilities
    can :read, Lot
  end

  def admin_abilities
    can :manage, :all
  end
end
