class AddSpecificValueFields < ActiveRecord::Migration[7.0]
  def change
    add_column :taggings, :number_value, :integer
    add_column :taggings, :date_value, :date
    add_reference :taggings, :user_value, null: true, foreign_key: { to_table: :users }
  end
end
