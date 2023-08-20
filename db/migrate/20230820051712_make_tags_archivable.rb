class MakeTagsArchivable < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :archived_at, :datetime
  end
end
