class RemovePriorityFromTicket < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :priority
  end
end
