class AddUserToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :creator, null: true, foreign_key: { to_table: :users }

    reversible do |dir|
      dir.up do
        Comment.all.each do |tr|
          tr.creator = User.first
          tr.save
        end

        change_column_null :comments, :creator_id, false
      end
    end

  end
end
