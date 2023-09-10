# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end

    # TODO: Refine me
    if (user.roles || []).include?("User")
      can %i[create read update], Ticket, creator_id: user.id
      can :update, Ticket, assignee_id: user.id
    end

    if (user.roles || []).include?("Approver")
      can :approve, Ticket
    end

    can %i[read select], Project, user_project_roles: { user_id: user.id, role: ['guest', :guest, 'admin', :admin, 'user', :user, 'reporter', :reporter]}
    can [:read, :inbox], Ticket, project: { user_project_roles: { user_id: user.id, role: ['guest', :guest, 'admin', :admin, 'user', :user, 'reporter', :reporter]}}
    can [:create], Ticket
    can [:update, :tag], Ticket, project: { user_project_roles: { user_id: user.id, role: ['admin', :admin, 'user', :user, 'reporter', :reporter]}}
    can :manage, Tag, project: { user_project_roles: { user_id: user.id, role: ['admin', :admin]}}

    can :ticket_form, TagGroup

    can %i[read edit], Ticket, creator_id: user.id
    can %i[create read], Comment, ticket: { creator_id: user.id }
  end
end
