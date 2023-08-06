class UserProjectRole < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :project

  enumerize :role, in: [:guest, :reporter, :user, :admin]
end
