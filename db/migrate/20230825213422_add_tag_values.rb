class AddTagValues < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :value_type, :string
    add_column :taggings, :value, :string
  end
end
