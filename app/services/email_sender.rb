class EmailSender
  def self.handle_default_notifications(ticket)
    if ticket.previously_new_record?
      TicketsMailer.created(ticket, ticket.creator).deliver
      if ticket.assignee.present? && ticket.assignee != ticket.creator
        TicketsMailer.created(ticket, ticket.assignee).deliver
      end
    end

    if ticket.saved_change_to_assignee_id
      TicketsMailer.assigned(ticket, ticket.assignee).deliver
    end
  end

  def self.handle_ticket_notification(ticket, notification_config)
    if ticket.previously_new_record?
      if !notification_config.filter? || notification_config.filter == :create
        message = format('New ticket: %<identifier>s %<title>s',
                         identifier: ticket.identifier, title: ticket.title)
      send_email(message)
      end
    elsif notification_config.filter == :sla
      message = format('SLA breach detected for ticket %<identifier>s %<title>s',
                       identifier: ticket.identifier, title: ticket.title)
      send_email(message)
    end
  end

  def self.send_email(message)
    # TODO send email
  end

end
