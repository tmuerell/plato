class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  include TicketsHelper

  belongs_to :ticket
  belongs_to :creator, class_name: "User"

  after_create_commit { broadcast_append_to dom_id(self.ticket, :comments) }

  after_create :send_notifications, if: lambda { ENV.fetch("PLATO_NOTIFICATIONS_ENABLED", "true") == "true" }

  def send_notifications
    handle_notifications(ticket, :commented)
  end
end
