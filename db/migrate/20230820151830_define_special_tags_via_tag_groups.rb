class DefineSpecialTagsViaTagGroups < ActiveRecord::Migration[7.0]
  def up
    TagGroup::NAMES.each do |name|
      TagGroup.find_or_create_by(name: name)
    end

    add_column :projects, :approvals, :boolean, default: false
    add_column :projects, :areas, :boolean, default: false
    add_column :projects, :boards, :boolean, default: false
    add_column :projects, :severities, :boolean, default: false

    approval = TagGroup.find_by(name: TagGroup::APPROVAL_NAME)
    Tag.where("name in (?)", ["NeedsApproval", "NeedsCLevelApproval"]).each do |tag|
      tag.tag_group = approval
      tag.save

      project = tag.project
      project.approval = true
      project.save
    end

    area = TagGroup.find_by(name: TagGroup::AREA_NAME)
    Tag.where(is_area: true).each do |tag|
      tag.tag_group = area
      tag.save

      project = tag.project
      project.area = true
      project.save
    end

    board = TagGroup.find_by(name: TagGroup::BOARD_NAME)
    Tag.where(is_board: true).each do |tag|
      tag.tag_group = board
      tag.save

      project = tag.project
      project.board = true
      project.save
    end

    remove_column :tags, :is_area
    remove_column :tags, :is_board
  end

  def down
    add_column :tags, :is_area, :boolean, default: false
    add_column :tags, :is_board, :boolean, default: false

    area = TagGroup.find_by(name: TagGroup::AREA_NAME)
    area&.tags&.each do |tag|
      tag.is_area = true
      tag.save
    end

    board = TagGroup.find_by(name: TagGroup::BOARD_NAME)
    board&.tags&.each do |tag|
      tag.is_board = true
      tag.save
    end

    remove_column :projects, :approvals
    remove_column :projects, :areas
    remove_column :projects, :boards
    remove_column :projects, :severities

    TagGroup::NAMES.each do |name|
      TagGroup.find_by(name: name)&.destroy
    end
  end
end
