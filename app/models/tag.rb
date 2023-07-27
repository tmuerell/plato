class Tag < ApplicationRecord
  belongs_to :project

  def approval?
    %w[NeedsApproval NeedsCLevelApproval].include? self.name
  end
end
