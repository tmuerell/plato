class AddDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :roles, :text
    add_reference :users, :current_project, null: true, foreign_key: { to_table: :projects }
  end
end
