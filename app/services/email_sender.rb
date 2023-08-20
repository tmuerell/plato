class EmailSender
  def self.handle_ticket_notification(ticket, notification_config, action)
    case action
    when :created
      if notification_config.for_action?(:created)
        TicketsMailer.created(ticket, notification_config.email_recepient_to, notification_config.email_recepient_bcc)
      end
    when :sla_breached
      if notification_config.for_action?(:sla_breached)
        TicketsMailer.sla_breached(ticket, notification_config.email_recepient_to,
                                   notification_config.email_recepient_bcc)
      end
    end
  end

  def self.handle_default_notifications(ticket, action)
    case action
    when :created
      handle_default_created(ticket)
    when :commented
      handle_default_commented(ticket)
    when :edited
      handle_default_edited(ticket)
    when :assignee_changed
      handle_default_assignee_changed(ticket)
    when :status_changed
      handle_default_status_changed(ticket)
    end
  end

  def self.handle_default_created(ticket)
    if ticket.creator.email?
      TicketsMailer.created(ticket, ticket.creator.email).deliver
    end
    if ticket.assignee.present? && ticket.assignee != ticket.creator && ticket.assignee.email?
      TicketsMailer.created(ticket, ticket.assignee.email).deliver
    end
  end

  def self.handle_default_commented(ticket)
    if ticket.creator.email?
      TicketsMailer.commented(ticket, ticket.creator.email).deliver
    end
    if ticket.assignee.present? && ticket.assignee != ticket.creator && ticket.assignee.email?
      TicketsMailer.commented(ticket, ticket.assignee.email).deliver
    end
  end

  def self.handle_default_edited(ticket)
    ticket.watchers.each do |watcher|
      if watcher.email?
        TicketsMailer.edited(ticket, watcher.email).deliver
      end
    end
  end

  def self.handle_default_assignee_changed(ticket)
    # TODO: send to last assignee if removed.  (Blocked by #24)
    if ticket.assignee.present? && ticket.assignee.email?
      TicketsMailer.assignee_changed(ticket, ticket.assignee.email).deliver
    end
  end

  def self.handle_default_status_changed(ticket)
    ticket.watchers.each do |watcher|
      if watcher.email?
        TicketsMailer.status_changed(ticket, watcher.email).deliver
      end
    end
  end
end
