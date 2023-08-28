class Tag < ApplicationRecord
  belongs_to :project
  belongs_to :tag_group, optional: true
  has_many :taggings

  default_scope { where(archived_at: nil) }
  scope :archived, -> { unscope(where: 'archived_at').where.not(archived_at: nil) }

  def approval?
    project.approval_tags.map(&:name).include? self.name
  end

  def area?
    project.area_tags.map(&:name).include? self.name
  end

  def board?
    project.board_tags.map(&:name).include? self.name
  end

  def severity?
    project.severity_tags.map(&:name).include? self.name
  end

  def value?
    value_type.present?
  end
end
