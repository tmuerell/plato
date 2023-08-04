# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if (user.roles || []).include?("Admin")
      can :manage, :all
    end

    # TODO: Refine me
    if (user.roles || []).include?("User")
      can [:create, :read, :update], Ticket, creator_id: user.id
      can :update, Ticket, assignee_id: user.id
    end

    if (user.roles || []).include?("Approver")
      can :approve, Ticket
    end

    can [:read, :select], Project
    can [:create, :read], Ticket, creator_id: user.id
    can [:create, :read], Comment, ticket: { creator_id: user.id }
  end
end
