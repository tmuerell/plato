class Tag < ApplicationRecord
  belongs_to :project
  has_many :taggings

  default_scope { where(archived_at: nil) }
  scope :archived, -> { unscope(where: 'archived_at').where.not(archived_at: nil) }

  def self.approval_tag_names
    %w[NeedsApproval NeedsCLevelApproval]
  end

  def approval?
    Tag.approval_tag_names.include? self.name
  end
end
