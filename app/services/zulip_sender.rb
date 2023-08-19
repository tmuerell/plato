require 'rest-client'

class ZulipSender
  def self.handle_ticket_notification(ticket, notification_config)
    if ticket.previously_new_record?
      if notification_config.is_for_action?(:created)
        message = format('New ticket for project %<project>s: %<title>s', project: ticket.project.name, title: ticket.title)
        send_message(notification_config.zulip_url,
                     notification_config.zulip_username,
                     notification_config.zulip_password,
                     notification_config.zulip_stream,
                     notification_config.zulip_topic,
                     message)
      end
    elsif notification_config.is_for_action?(:sla_breached)
      message = format('SLA breach detected for ticket %<identifier>s %<title>s',
                       identifier: ticket.identifier, title: ticket.title)
      create_incident(notification_config.pager_duty_service_key,
                      message)
    end
  end

  def self.send_message(url, username, password, to, topic, content)
    response = RestClient::Request.new(
      method: :post,
      url: format('%s/api/v1/messages', url),
      user: username,
      password:,
      payload: {
        type: 'stream',
        to:,
        topic:,
        content:
      }
    ).execute

    raise format('HTTP code %d', response.code) if response.code != '200'
  end
end
