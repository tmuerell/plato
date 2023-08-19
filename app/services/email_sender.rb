class EmailSender
  def self.handle_default_notifications(ticket, action)
    case action
    when :created
      TicketsMailer.created(ticket, ticket.creator.email).deliver
      if ticket.assignee.present? && ticket.assignee != ticket.creator
        TicketsMailer.created(ticket, ticket.assignee.email).deliver
      end
    when :edited
      TicketsMailer.edited(ticket, ticket.watchers).deliver
    when :assignee_changed
      TicketsMailer.assigned(ticket, ticket.assignee).deliver
    when :status_changed
      TicketsMailer.status_changed(ticket, ticket.watchers).deliver
    end
  end

  def self.handle_ticket_notification(ticket, notification_config, action)
    case action
    when :created
      if notification_config.is_for_action?(:created)
        TicketsMailer.created(ticket, notification_config.email_recepient_to, notification_config.email_recepient_bcc)
      end
    when :sla_breached
      if notification_config.is_for_action?(:sla_breached)
        TicketsMailer.sla_breached(ticket, notification_config.email_recepient_to, notification_config.email_recepient_bcc)
      end
    end
  end
end
