require 'net/http'
require 'uri'

class ZulipSender
  def self.handle_ticket_notification(ticket, notification_config)
    if ticket.previously_new_record?
      if !notification_config.filter? || notification_config.filter == :create
        message = format('New ticket for project %<project>s: %<title>s', project: ticket.project.name, title: ticket.title)
        send_message(notification_config.zulip_url,
                     notification_config.zulip_username,
                     notification_config.zulip_password,
                     notification_config.zulip_stream,
                     notification_config.zulip_topic,
                     message)
      end
    elsif notification_config.filter == :sla
      message = format('SLA breach detected for ticket %<identifier>s %<title>s',
                       identifier: ticket.identifier, title: ticket.title)
      create_incident(notification_config.pager_duty_service_key,
                      message)
    end
  end

  def self.send_message(url, username, password, to, topic, content)
    uri = URI.parse(format('%s/api/v1/messages', url))

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth(username, password)
    request.body = JSON.generate(
      {
        type: 'stream',
        to:,
        topic:,
        content:
      }
    )
    puts request.body

    response = http.request(request)
    puts response.body

    raise response.message if response.code != '200'
  end
end
