class Ability
  include CanCan::Ability

  def initialize(user)
    if user == :user
      can :manage, Bizarroids::Settings::Option
    end
  end
end
