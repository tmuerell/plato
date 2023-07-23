# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if (user.roles || []).include?("Admin")
      can :manage, :all
    end
  end
end
