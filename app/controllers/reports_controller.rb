class ReportsController < ApplicationController
  def sla
    @tickets = current_project.tickets.accessible_by(current_ability).where("exists ( select 1 from ticket_transitions t where t.created_at between ? and ? and t.ticket_id = tickets.id)", Time.now - 1.month, Time.now)
  end
end
