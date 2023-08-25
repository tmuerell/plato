class Ticket < ApplicationRecord
  extend Enumerize
  include TicketsHelper

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
  has_many :ticket_transitions

  before_save :update_transition_before
  before_create :set_sequential_no
  after_save :update_transition_after

  validates_presence_of :title, :priority
  validate :max_one_tag_per_tag_group

  enumerize :priority, in: [:normal, :high]
  scope :with_tag, lambda { |tag| joins(:tags).where(tags: { id: tag.id }) }
  after_commit :send_notifications, if: lambda { ENV.fetch("PLATO_NOTIFICATIONS_ENABLED", "true") == "true" }

  def identifier
    "%s:%06x" % [project.shortname, sequential_id]
  end

  def identifier=(identifier)
    super(identifier)
  end

  def sla_status
    return :ok unless self.last_transition_at
    sla = project.sla_for(self.status)
    seconds = (Time.now - self.last_transition_at)

    project.calculate_sla_status(self.status, seconds)
  end

  def needs_approval?
    return false unless project.approvals?

    Ticket.left_outer_joins(:tags)
          .joins('LEFT OUTER JOIN "ticket_user_relationships" ON "ticket_user_relationships"."ticket_id" = "tickets"."id" AND "ticket_user_relationships"."relationship" = \'approval\'')
          .where('tags.name IN (?)', project.approval_tags.map(&:name))
          .where('tickets.id = ? AND ticket_user_relationships.id IS NULL', id)
          .exists?
  end

  def valid_transitions(_user)
    state = project.workflow["states"][self.status]
    (state["transitions"] || []).map { |k, _| k }
  end

  def end_state?(_user)
    state = project.workflow["states"][self.status]
    (state["transitions"] || []).empty?
  end

  def approved?
    ticket_user_relationships.any? { |r| r.relationship == :approval }
  end

  def flagged?
    self.tags.select { |t| t.name == 'Flag' }.first
  end

  def inbox?
    !Ticket.joins(tags: :tag_group)
           .where('tickets.id = ? AND tag_groups.name in (?)',
                  id,
                  [TagGroup::AREA_NAME, TagGroup::BOARD_NAME])
           .exists?
  end

  def watched?(user)
    Ticket.joins(:ticket_user_relationships)
          .where('tickets.id = ? AND ticket_user_relationships.user_id = ? AND ticket_user_relationships.relationship = ?',
                 id,
                 user.id,
                 :watch)
          .exists?
  end

  def watchers
    User.joins(:ticket_user_relationships)
        .where('ticket_user_relationships.ticket_id = ? AND ticket_user_relationships.relationship = ?', id, :watch)
  end

  def self.search(query, project, ability)
    by_identifier = Ticket.accessible_by(ability).find_by(identifier: query)
    return [by_identifier] if by_identifier

    query = Ticket.sanitize_sql_like(query)
    Ticket.where('tickets.project_id = ? AND lower(tickets.title) LIKE ?',
                 project.id,
                 "%#{query}%".downcase)
  end

  def set_value(tag, value)
    t = Tagging.new
    t.tag_id = tag.id
    t.taggable_id = id
    t.taggable_type = 'Ticket'
    t.value = value
    t.save
  end

  def value(tag)
    Tagging.find_by(tag: tag, taggable_id: id, taggable_type: "Ticket")&.value
  end

  def values
    Tagging.joins(:tag)
           .where('taggings.taggable_type = ? AND taggings.taggable_id = ? AND tags.value_type IS NOT NULL', 'Ticket', 1)
  end

  private

  def set_sequential_no
    self.status = self.project.init_state
    self.sequential_id = (Ticket.maximum(:sequential_id) || 1) + 1
    self.last_transition_at = Time.now
    self.identifier = identifier
  end

  def send_notifications
    handle_notifications(self, notification_action)
  end

  def notification_action
    if previously_new_record?
      :created
    elsif saved_change_to_assignee_id
      :assignee_changed
    elsif saved_change_to_status
      :status_changed
    else
      :edited
    end
  end

  def max_one_tag_per_tag_group
    used = {}
    tags.each do |tag|
      next unless tag.tag_group.present?

      used[tag.tag_group.name] = [] unless used.key? tag.tag_group.name
      used[tag.tag_group.name] << tag.name
    end

    used.each_key do |tag_group|
      errors.add(:tags, "must only have one tag in tag group #{tag_group}") if used[tag_group].count > 1
    end
  end

  protected

  def update_transition_before
    if will_save_change_to_status?
      self.last_transition_at = Time.now
    end
  end

  def update_transition_after
    unless self.previously_new_record? || !self.last_transition_at_before_last_save
      if saved_change_to_status
        TicketTransition.create!(ticket: self,
                                 from: self.status_before_last_save,
                                 to: self.status,
                                 duration: Time.now - self.last_transition_at_before_last_save)
      end
    end
  end
end
