class Ticket < ApplicationRecord
  extend Enumerize

  has_paper_trail

  belongs_to :project
  belongs_to :customer_project
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  has_many :comments
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :ticket_user_relationships

  before_create :set_sequential_no

  validates_presence_of :title, :priority

  enumerize :status, in: [:new, :in_progress, :blocked, :done]
  enumerize :priority, in: [:normal, :high]

  after_create :send_notifications

  def identifier
    "%s-%06x" % [project.shortname, sequential_id]
  end

  def needs_approval?
    # TODO: solve this with SQL
    tags.any?(&:approval?) && !approved?
  end

  def approved?
    ticket_user_relationships.any? { |r| r.relationship == :approval }
  end

  def on_board?
    # TODO: solve this with SQL
    tags.any?(&:is_board?)
  end

  private

  def set_sequential_no
    self.status = :new
    self.sequential_id = (Ticket.maximum(:sequential_id) || 1) + 1
  end

  def send_notifications
    TicketsMailer.created(self, self.creator).deliver
    if self.assignee.present? && self.assignee != self.creator
      TicketsMailer.created(self, self.assignee).deliver
    end
  end
end
