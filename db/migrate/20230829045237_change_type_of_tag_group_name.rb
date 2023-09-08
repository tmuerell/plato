class ChangeTypeOfTagGroupName < ActiveRecord::Migration[7.0]
  def change
    change_column :tag_groups, :name, :string, null: false
  end
end
