class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :shortname

      t.timestamps
    end
    add_index :projects, :shortname, unique: true
  end
end
