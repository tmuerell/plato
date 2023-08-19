require 'net/http'
require 'uri'

class PagerDutySender
  def self.handle_ticket_notification(ticket, notification_config)
    if ticket.previously_new_record?
      if !notification_config.filter? || notification_config.filter == :create
        message = format('New ticket: %<identifier>s %<title>s',
                         identifier: ticket.identifier, title: ticket.title)
        create_incident(notification_config.pager_duty_service_key,
                        message)
      end
    elsif notification_config.filter == :sla
      message = format('SLA breach detected for ticket %<identifier>s %<title>s',
                       identifier: ticket.identifier, title: ticket.title)
      create_incident(notification_config.pager_duty_service_key,
                      message)
    end
  end

  def self.create_incident(service_key, message)
    raise 'PLATO_PAGER_DUTY_TOKEN is unset' unless ENV.include?('PLATO_PAGER_DUTY_TOKEN')

    @pager_duty_token ||= ENV['PLATO_PAGER_DUTY_TOKEN']

    # https://developer.pagerduty.com/docs/ZG9jOjExMDI5NTY0-incident-creation-api
    # https://developer.pagerduty.com/api-reference/a7d81b0e9200f-create-an-incident
    response = RestClient::Request.new(
      method: :post,
      url: 'https://api.pagerduty.com/incidents',
      headers: {
        accept: 'application/vnd.pagerduty+json;version=2',
        'Content-Type': 'application/json',
        'Authorization': format('Token token=%s', @pager_duty_token)
      },
      payload:{
        incident: {
          type: 'incident',
          title: message,
          service: {
            id: service_key,
            type: 'service_reference'
          }
        }
      }
    ).execute

    raise format('HTTP code %d', response.code) if response.code != '201'
  end
end
