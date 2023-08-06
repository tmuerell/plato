class CreateUserProjectRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_project_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
