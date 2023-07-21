module TicketsHelper
  def priority_label(ticket)
    if ticket.priority.normal?
      content_tag(:span, ticket.priority_text, class: 'badge bg-info')
    elsif ticket.priority.high?
      content_tag(:span, ticket.priority_text, class: 'badge bg-warning')
    else
      content_tag(:span, ticket.priority_text, class: 'badge bg-secondary')
    end
  end
  def status_label(ticket)
    if ticket.status.new?
      content_tag(:span, ticket.status_text, class: 'badge bg-secondary')
    elsif ticket.status.in_progress?
      content_tag(:span, ticket.status_text, class: 'badge bg-info')
    elsif ticket.status.blocked?
      content_tag(:span, ticket.status_text, class: 'badge bg-warning')
    elsif ticket.status.done?
      content_tag(:span, ticket.status_text, class: 'badge bg-success')
    else
      content_tag(:span, ticket.status_text, class: 'badge bg-secondary')
    end
  end
end
