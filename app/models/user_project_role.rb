class UserProjectRole < ApplicationRecord
  ROLES = [:guest, :reporter, :user, :admin]

  extend Enumerize

  belongs_to :user
  belongs_to :project

  enumerize :role, in: ROLES
end
