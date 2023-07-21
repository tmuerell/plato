class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :sequential_id
      t.text :title
      t.text :content
      t.references :project, null: false, foreign_key: true
      t.string :status
      t.string :priority
      t.references :customer_project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
