class AddDurationToTicketTransition < ActiveRecord::Migration[7.0]
  def change
    add_column :ticket_transitions, :duration, :integer
  end
end
