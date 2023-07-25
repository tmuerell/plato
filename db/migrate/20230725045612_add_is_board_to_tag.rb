class AddIsBoardToTag < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :is_board, :boolean, default: false, null: false
  end
end
