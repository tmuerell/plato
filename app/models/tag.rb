class Tag < ApplicationRecord
  belongs_to :project
  belongs_to :tag_group, optional: true
  has_many :taggings

  default_scope { where(archived_at: nil) }
  scope :archived, -> { unscope(where: 'archived_at').where.not(archived_at: nil) }

  def approval?
    return false unless project.approvals?

    project.approval_tags.map(&:name).include? self.name
  end

  def area?
    return false unless project.areas?

    project.area_tags.map(&:name).include? self.name
  end

  def board?
    return false unless project.boards?

    project.board_tags.map(&:name).include? self.name
  end

  def severity?
    return false unless project.severities?

    project.severity_tags.map(&:name).include? self.name
  end

  def value?
    value_type.present?
  end
end
