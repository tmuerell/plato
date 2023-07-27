class TicketUserRelationship < ApplicationRecord
  extend Enumerize

  belongs_to :ticket
  belongs_to :user

  enumerize :relationship, in: [:approval]
end
