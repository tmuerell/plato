class EmailSender
  def self.handle_ticket_notification(ticket, notification_config, action)
    case action
    when :created
      if notification_config.for_action?(:created)
        TicketsMailer.created(ticket,
                              notification_config.email_recepient_to,
                              notification_config.email_recepient_bcc)
      end
    when :sla_breached
      if notification_config.for_action?(:sla_breached)
        TicketsMailer.sla_breached(ticket,
                                   notification_config.email_recepient_to,
                                   notification_config.email_recepient_bcc)
      end
    end
  end

  def self.handle_ticket_watcher_notifications(ticket, action)
    ticket.watchers
          .filter_map(&:email)
          .each do |email|
      case action
      when :commented
        TicketsMailer.commented(ticket, email).deliver
      when :edited
        TicketsMailer.edited(ticket, email).deliver
      when :assignee_changed
        TicketsMailer.assignee_changed(ticket, email).deliver
      when :status_changed
        TicketsMailer.status_changed(ticket, email).deliver
      end
    end
  end
end
