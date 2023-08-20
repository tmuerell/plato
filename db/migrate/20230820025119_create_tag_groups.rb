class CreateTagGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_groups do |t|
      t.text :name

      t.timestamps
    end

    add_reference :tags, :tag_group, index: true
  end
end
