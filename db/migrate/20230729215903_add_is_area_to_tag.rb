class AddIsAreaToTag < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :is_area, :boolean
  end
end
