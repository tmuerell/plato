class AddUserToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :creator, null: true, foreign_key: { to_table: :users }
    add_reference :tickets, :assignee, null: true, foreign_key: { to_table: :users }

    reversible do |dir|
      dir.up do
        Ticket.all.each do |tr|
          tr.creator = User.first
          tr.save
        end

        change_column_null :tickets, :creator_id, false
      end
    end
  end
end
