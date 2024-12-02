class Tag < ApplicationRecord
  belongs_to :project
  belongs_to :tag_group, optional: true
  has_many :taggings
  validate :tag_group_not_from_project

  default_scope { where(archived_at: nil) }
  scope :archived, -> { unscope(where: 'archived_at').where.not(archived_at: nil) }

  def approval?
    project.approval_tags.map(&:id).include? self.id
  end

  def area?
    project.area_tags.map(&:id).include? self.id
  end

  def board?
    project.board_tags.map(&:id).include? self.id
  end

  def severity?
    project.severity_tags.map(&:id).include? self.id
  end

  def value?
    value_type.present?
  end

  protected

  def tag_group_not_from_project
    if self.tag_group && self.tag_group.project.id != self.project.id
      errors.add :tag_group, "is not from the project"
    end
  end
end
