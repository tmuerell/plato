require 'net/http'
require 'uri'

class PagerDutySender
  def self.send_ticket_notification(ticket, notification_config)
    message = format("Notification for ticket '%s'", ticket.title)
    create_incident(notification_config.pager_duty_service_key,
                    message)
  end

  def self.create_incident(service_key, message)
    raise "PLATO_PAGER_DUTY_TOKEN is unset" unless ENV.include?('PLATO_PAGER_DUTY_TOKEN')

    @pager_duty_token ||= ENV['PLATO_PAGER_DUTY_TOKEN']

    # https://developer.pagerduty.com/docs/ZG9jOjExMDI5NTY0-incident-creation-api
    # https://developer.pagerduty.com/api-reference/a7d81b0e9200f-create-an-incident
    uri = URI.parse('https://api.pagerduty.com/incidents')
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request['Accept'] = 'application/vnd.pagerduty+json;version=2'
    request['Content-Type'] = 'application/json'
    request['Authorization'] = format('Token token=%s', @pager_duty_token)
    request.body = JSON.generate(
      {
        incident: {
          type: 'incident',
          title: message,
          service: {
            id: service_key,
            type: 'service_reference'
          }
        }
      }
    )
    puts request.body

    response = http.request(request)
    puts response.body

    raise response.message if response.code != '200'
  end
end
