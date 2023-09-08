class ProjectGroupMapping < ApplicationRecord
  extend Enumerize

  belongs_to :project
  enumerize :role, in: UserProjectRole::ROLES

  validates_presence_of :group, :role
end
