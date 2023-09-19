module TicketsHelper
  def sla_label(sla_status)
    if sla_status == :error
      content_tag(:span, "SLA Breached", class: 'badge bg-danger')
    elsif sla_status == :warning
      content_tag(:span, "SLA Warning", class: 'badge bg-warning')
    elsif sla_status == :ok
      content_tag(:span, "SLA OK", class: 'badge bg-success')
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

  def linked_ticket_identifier(ticket)
    content_tag :span, ticket.identifier, 'data-ticket-identifier': ticket.identifier do
      link_to(ticket.identifier, ticket) +
        content_tag(:span,
                    '🔗',
                    title: 'Copy to clipboard',
                    class: 'copy-to-clipboard',
                    data: { controller: 'tickets',
                            action: 'click->tickets#copyToClipboard' })
    end
  end

  def handle_notifications(ticket, action)
    EmailSender.handle_ticket_watcher_notifications(ticket, action)

    NotificationConfig.where(project: ticket.project).all.each do |nc|
      nc.handle_ticket(self, action)
    end
  end
end
