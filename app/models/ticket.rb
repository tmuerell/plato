class Ticket < ApplicationRecord
  extend Enumerize

  belongs_to :project
  belongs_to :customer_project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  has_many :comments

  before_create :set_sequential_no

  validates_presence_of :title, :priority

  enumerize :status, in: [:new, :in_progress, :blocked, :done]
  enumerize :priority, in: [:normal, :high]

  def identifier
    "%s-%06x" % [ project.shortname, sequential_id ]
  end

  private

  def set_sequential_no
    self.status = :new
    self.sequential_id = (Ticket.maximum(:sequential_id) || 1) + 1
  end
end
