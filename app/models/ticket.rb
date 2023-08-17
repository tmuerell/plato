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
  has_many_attached :files
  has_many :child_relationships, foreign_key: :parent_id, class_name: "TicketTicketRelationship", dependent: :destroy
  has_many :children, through: :child_relationships
  has_many :parent_relationships, foreign_key: :child_id, class_name: "TicketTicketRelationship", dependent: :destroy
  has_many :parents, through: :parent_relationships

  before_create :set_sequential_no

  validates_presence_of :title, :priority

  enumerize :priority, in: [:normal, :high]
  scope :with_tag, lambda { |tag| joins(:tags).where(tags: { id: tag.id }) }
  after_commit :send_notifications, if: lambda { ENV.fetch("PLATO_NOTIFICATIONS_ENABLED", "true") == "true" }

  def identifier
    "%s:%06x" % [project.shortname, sequential_id]
  end

  def needs_approval?
    Ticket.left_outer_joins(:tags)
          .joins('LEFT OUTER JOIN "ticket_user_relationships" ON "ticket_user_relationships"."ticket_id" = "tickets"."id" AND "ticket_user_relationships"."relationship" = \'approval\'')
          .where('tags.name IN (?)', Tag.approval_tag_names)
          .where('tickets.id = ? AND ticket_user_relationships.id IS NULL', id)
          .exists?
  end

  def valid_transitions(_user)
    state = project.workflow["states"][self.status]
    (state["transitions"] || []).map { |k,_| k}
  end

  def approved?
    ticket_user_relationships.any? { |r| r.relationship == :approval }
  end

  def flagged?
    self.tags.select { |t| t.name == 'Flag'}.first
  end

  def inbox?
    !Ticket.joins(:tags).where('tickets.id = ? AND (tags.is_board = true OR tags.is_area = true)', id).exists?
  end

  private

  def set_sequential_no
    self.status = self.project.init_state
    self.sequential_id = (Ticket.maximum(:sequential_id) || 1) + 1
  end

  def send_notifications
    if self.previously_new_record?
      TicketsMailer.created(self, self.creator).deliver
      if self.assignee.present? && self.assignee != self.creator
        TicketsMailer.created(self, self.assignee).deliver
      end
    end
    if self.saved_change_to_assignee_id
      TicketsMailer.assigned(self, self.assignee).deliver
    end
  end
end
