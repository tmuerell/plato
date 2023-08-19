require 'net/http'
require 'uri'

class ZulipSender
  def self.send_ticket_notification(ticket, notification_config)
    message = format("Notification for ticket '%s'", ticket.title)
    send_message(notification_config.zulip_url,
                 notification_config.zulip_username,
                 notification_config.zulip_password,
                 notification_config.zulip_stream,
                 notification_config.zulip_topic,
                 message)
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
