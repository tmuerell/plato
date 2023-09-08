class AddGroupsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :groups, :text
  end
end
