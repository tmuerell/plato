class NotificationConfig < ApplicationRecord
  extend Enumerize

  belongs_to :project

  enumerize :delivery_type, in: [:email, :pager_duty, :zulip]

  def handle_ticket(ticket)
    return unless filter_match?(ticket)

    case delivery_type
    when :email
      logger.debug 'Sending email'
    when :pager_duty
      logger.debug 'Creating incident in PagerDuty'
    when :zulip
      ZulipSender.send_ticket_notification(ticket, self)
    end
  end

  def filter_match?(_ticket)
    return true unless filter.present?

    # TODO
    true
  end
end
