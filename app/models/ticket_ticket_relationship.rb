class TicketTicketRelationship < ApplicationRecord
  extend Enumerize

  belongs_to :parent, class_name: 'Ticket'
  belongs_to :child, class_name: 'Ticket'

  enumerize :relationship, in: [:depends_on, :blocks, :succeeds]
end
