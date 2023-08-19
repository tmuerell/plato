class EmailSender
  def self.handle_default_notifications(ticket)
    if ticket.previously_new_record?
      TicketsMailer.created(ticket, ticket.creator.email).deliver
      if ticket.assignee.present? && ticket.assignee != ticket.creator
        TicketsMailer.created(ticket, ticket.assignee.email).deliver
      end
    else
      TicketsMailer.edited(self, self.watchers).deliver
    end

    if ticket.saved_change_to_assignee_id
      TicketsMailer.assigned(ticket, ticket.assignee).deliver
    end
    if self.saved_change_to_status
      TicketsMailer.status_changed(self, self.watchers).deliver
    end
  end

  def self.handle_ticket_notification(ticket, notification_config)
    if ticket.previously_new_record?
      if notification_config.is_for_action?(:created)
        message = format('New ticket: %<identifier>s %<title>s',
                         identifier: ticket.identifier, title: ticket.title)
        TicketsMailer.created(ticket, notification_config.email_recepient_to, notification_config.email_recepient_bcc)
      end
    elsif notification_config.is_for_action?(:sla_breached)
      message = format('SLA breach detected for ticket %<identifier>s %<title>s',
                       identifier: ticket.identifier, title: ticket.title)
      TicketsMailer.sla_breached(ticket, notification_config.email_recepient_to, notification_config.email_recepient_bcc)
    end
  end
end
