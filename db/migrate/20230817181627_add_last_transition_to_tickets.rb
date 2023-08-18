class AddLastTransitionToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :last_transition_at, :datetime
  end
end
