class TicketTicketRelationshipsController < ApplicationController
  def create
    @ticket_ticket_relationship = TicketTicketRelationship.new(ticket_ticket_relationship_params)
    @ticket_ticket_relationship.save!
    redirect_to @ticket_ticket_relationship.parent
  end

  private

  def ticket_ticket_relationship_params
    params.require(:ticket_ticket_relationship).permit(:parent_id, :child_id, :relationship)
  end
end
