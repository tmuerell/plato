require 'rest-client'

class ZulipSender
  def self.handle_ticket_notification(ticket, notification_config, action)
    case action
    when :created
      if notification_config.for_action?(:created)
        ac = ActionController::Base.new
        message = ac.render_to_string(template: '/tickets_zulip/created',
                                      layout: false,
                                      locals: { ticket: })
        send_message(notification_config.zulip_url,
                     notification_config.zulip_username,
                     notification_config.zulip_password,
                     notification_config.zulip_stream,
                     notification_config.zulip_topic,
                     message)
      end
    when :sla_breached
      if notification_config.for_action?(:sla_breached)
        ac = ActionController::Base.new
        message = ac.render_to_string(template: '/tickets_zulip/sla_breached',
                                      layout: false,
                                      locals: { ticket: ticket })
        send_message(notification_config.zulip_url,
                   notification_config.zulip_username,
                   notification_config.zulip_password,
                   notification_config.zulip_stream,
                   notification_config.zulip_topic,
                   message)
      end
    end
  end

  def self.send_message(url, username, password, to, topic, content)
    response = RestClient::Request.new(
      method: :post,
      url: "#{url}/api/v1/messages",
      user: username,
      password: password,
      payload: {
        type: 'stream',
        to: to,
        topic: topic,
        content: content,
      }
    ).execute

    raise "HTTP code #{response.code}" if response.code != 200
  end
end
