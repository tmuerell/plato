module TicketsHelper
  def priority_label(ticket)
    if ticket.priority.normal?
      content_tag(:span, ticket.priority, class: 'badge bg-info')
    elsif ticket.priority.high?
      content_tag(:span, ticket.priority, class: 'badge bg-warning')
    else
      content_tag(:span, ticket.priority, class: 'badge bg-secondary')
    end
  end

  def sla_label(ticket)
    if ticket.sla_status == :error
      content_tag(:span, "SLA breached", class: 'badge bg-danger')
    elsif ticket.sla_status == :warning
      content_tag(:span, "SLA Warning", class: 'badge bg-warning')
    end
  end

  def status_label(ticket)
    if ticket.status == "new"
      content_tag(:span, ticket.status, class: 'badge bg-light text-secondary')
    elsif ticket.status == "in_progress"
      content_tag(:span, ticket.status, class: 'badge bg-info')
    elsif ticket.status == "blocked"
      content_tag(:span, ticket.status, class: 'badge bg-warning')
    elsif ticket.status == "done"
      content_tag(:span, ticket.status, class: 'badge bg-success')
    else
      content_tag(:span, ticket.status, class: 'badge bg-secondary')
    end
  end
end
