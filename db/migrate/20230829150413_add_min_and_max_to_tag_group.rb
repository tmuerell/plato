class AddMinAndMaxToTagGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :tag_groups, :min_count, :number, null: true
    add_column :tag_groups, :max_count, :number, null: true

    TagGroup.where(name: TagGroup::BOARD_NAME).each do |board|
      # TODO: needs support in ticket create form
      # severity.min_count = 1
      board.max_count = 1
      board.save!
    end

    TagGroup.where(name: TagGroup::SEVERITY_NAME).each do |severity|
      # TODO: needs support in ticket create form
      # severity.min_count = 1
      severity.max_count = 1
      severity.save!
    end
  end
end
