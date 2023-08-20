class Tag < ApplicationRecord
  belongs_to :project
  belongs_to :tag_group, optional: true
  has_many :taggings

  def self.approval_tag_names
    %w[NeedsApproval NeedsCLevelApproval]
  end

  def approval?
    Tag.approval_tag_names.include? self.name
  end
end
