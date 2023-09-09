class CreateProjectGroupMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :project_group_mappings do |t|
      t.references :project, null: false, foreign_key: true
      t.string :group
      t.string :role

      t.timestamps
    end
  end
end
