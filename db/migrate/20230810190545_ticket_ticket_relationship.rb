class TicketTicketRelationship < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_ticket_relationships do |t|
      t.references :parent, null: false, foreign_key: { to_table: :tickets }
      t.references :child, null: false, foreign_key: { to_table: :tickets }
      t.string :relationship

      t.timestamps
    end
  end
end
