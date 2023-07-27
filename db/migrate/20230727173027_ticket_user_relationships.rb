class TicketUserRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :ticket_user_relationships do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :relationship

      t.timestamps
    end
  end
end
