class Comment < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :ticket
  belongs_to :creator, class_name: "User"

  after_create_commit { broadcast_append_to dom_id(self.ticket, :comments) }

  after_create :send_notifications

  def send_notifications
    TicketsMailer.commented(self.ticket, self.ticket.creator).deliver
    if self.ticket.assignee.present? && self.ticket.assignee != self.ticket.creator
      TicketsMailer.commented(self.ticket, self.ticket.assignee).deliver
    end
  end
end
