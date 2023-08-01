class Tag < ApplicationRecord
  belongs_to :project
  has_many :taggings

  def self.approval_tag_names
    %w[NeedsApproval NeedsCLevelApproval]
  end

  def approval?
    Tag.approval_tag_names.include? self.name
  end
end
