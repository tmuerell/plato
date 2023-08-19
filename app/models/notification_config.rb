class NotificationConfig < ApplicationRecord
  extend Enumerize

  belongs_to :project

  enumerize :delivery_type, in: [:email, :pager_duty, :zulip]

  validates_presence_of :delivery_type
  validate :params_match_delivery_type

  def handle_ticket(ticket, action)
    case delivery_type
    when 'email'
      EmailSender.handle_ticket_notification(ticket, self, action)
    when 'pager_duty'
      PagerDutySender.handle_ticket_notification(ticket, self, action)
    when 'zulip'
      ZulipSender.handle_ticket_notification(ticket, self, action)
    end
  end

  def is_for_action?(action)
    if filter.present?
      actions = filter.split(',').map(&:strip).map(&:to_sym)
    else
      actions = []
    end

    case action
    when :created
      actions.empty? || actions.include?(:created)
    when :edited
      actions.include?(:edited)
    when :sla_breached
      actions.include?(:sla_breached)
    when :status_changed
      actions.include?(:status_changed)
    else
      raise "unhandled action '%s'" % [action]
    end
  end

  def params_match_delivery_type
    case delivery_type
    when 'email'
      errors.add(:email_recepient_to, "must be set for delivery_type 'email'") unless email_recepient_to.present?
      errors.add(:email_recepient_bcc, "must be set for delivery_type 'email'") unless email_recepient_bcc.present?
      errors.add(:email_subject, "must be set for delivery_type 'email'") unless email_subject.present?
    when 'pager_duty'
      unless pager_duty_service_key.present?
        errors.add(:pager_duty_service_key, "must be set for delivery_type 'pager_duty'")
      end
    when 'zulip'
      errors.add(:zulip_url, "must be set for delivery_type 'zulip'") unless zulip_url.present?
      errors.add(:zulip_username, "must be set for delivery_type 'zulip'") unless zulip_username.present?
      errors.add(:zulip_password, "must be set for delivery_type 'zulip'") unless zulip_password.present?
      errors.add(:zulip_stream, "must be set for delivery_type 'zulip'") unless zulip_stream.present?
      errors.add(:zulip_topic, "must be set for delivery_type 'zulip'") unless zulip_topic.present?
    else
      errors.add(:delivery_type, "unhandled delivery_type '%s'" % [delivery_type])
    end
  end
end
