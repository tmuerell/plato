class CreateTicketTransitions < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_transitions do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
