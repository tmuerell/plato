class NotificationConfig < ApplicationRecord
  extend Enumerize

  belongs_to :project

  enumerize :delivery_type, in: [:email, :pager_duty, :zulip]

  validates_presence_of :delivery_type
  validate :params_match_delivery_type

  def handle_ticket(ticket, action)
    if delivery_type.email?
      EmailSender.handle_ticket_notification(ticket, self, action)
    elsif delivery_type.pager_duty?
      PagerDutySender.handle_ticket_notification(ticket, self, action)
    elsif delivery_type.zulip?
      ZulipSender.handle_ticket_notification(ticket, self, action)
    end
  end

  def actions
    if filter.present?
      filter.split(',').map(&:strip).map(&:to_sym)
    else
      []
    end
  end

  def for_action?(action)
    actions = self.actions

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
      raise "unhandled action '#{action}'"
    end
  end

  def params_match_delivery_type
    if delivery_type.email?
      validate_email_params
    elsif delivery_type.pager_duty?
      validate_pager_duty_params
    elsif delivery_type.zulip?
      validate_zulip_params
    else
      errors.add(:delivery_type, "unhandled delivery_type '#{delivery_type}'")
    end
  end

  private

  def validate_email_params
    errors.add(:email_recepient_to, "must be set for delivery_type 'email'") unless email_recepient_to.present?
    errors.add(:email_recepient_bcc, "must be set for delivery_type 'email'") unless email_recepient_bcc.present?
  end

  def validate_pager_duty_params
    errors.add(:pager_duty_service_key, "must be set for delivery_type 'pager_duty'") unless pager_duty_service_key.present?
  end

  def validate_zulip_params
    errors.add(:zulip_url, "must be set for delivery_type 'zulip'") unless zulip_url.present?
    errors.add(:zulip_username, "must be set for delivery_type 'zulip'") unless zulip_username.present?
    errors.add(:zulip_password, "must be set for delivery_type 'zulip'") unless zulip_password.present?
    errors.add(:zulip_stream, "must be set for delivery_type 'zulip'") unless zulip_stream.present?
    errors.add(:zulip_topic, "must be set for delivery_type 'zulip'") unless zulip_topic.present?
  end
end
