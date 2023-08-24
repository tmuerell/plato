class PersistTicketIdentifier < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :identifier, :text, null: true

    Ticket.all.each do |ticket|
      identifier = "%s:%06x" % [ticket.project.shortname, ticket.sequential_id]
      ticket.identifier = identifier
      ticket.save!
    end

    change_column :tickets, :identifier, :text, null: false
    add_index :tickets, :identifier
  end
end
