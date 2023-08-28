class AddProjectToTagGroup < ActiveRecord::Migration[7.0]
  def change
    approval = TagGroup.find_by(name: TagGroup::APPROVAL_NAME)
    approval.tags.each do |tag|
      tag.taggings.each(&:destroy)
      tag.destroy
    end
    approval.destroy

    area = TagGroup.find_by(name: TagGroup::AREA_NAME)
    area.tags.each do |tag|
      tag.taggings.each(&:destroy)
      tag.destroy
    end
    area.destroy

    board = TagGroup.find_by(name: TagGroup::BOARD_NAME)
    board.tags.each do |tag|
      tag.taggings.each(&:destroy)
      tag.destroy
    end
    board.destroy

    severity = TagGroup.find_by(name: TagGroup::SEVERITY_NAME)
    severity.tags.each do |tag|
      tag.taggings.each(&:destroy)
      tag.destroy
    end
    severity.destroy

    add_reference :tag_groups, :project, null: false, foreign_key: true, index: true
    add_index :tag_groups, %i[project_id name], unique: true

    Project.all.each do |project|
      if project.approvals?
        tg = TagGroup.new
        tg.name = TagGroup::APPROVAL_NAME
        tg.project = project
        tg.save

        TagGroup::APPROVAL_DEFAULT_TAG_NAMES.each do |tag_name|
          tag = Tag.new
          tag.tag_group = tg
          tag.project = project
          tag.name = tag_name
          tag.save
        end
      end

      if project.areas?
        tg = TagGroup.new
        tg.name = TagGroup::AREA_NAME
        tg.project = project
        tg.save
      end

      if project.boards?
        tg = TagGroup.new
        tg.name = TagGroup::BOARD_NAME
        tg.project = project
        tg.save
      end

      if project.seveities?
        tg = TagGroup.new
        tg.name = TagGroup::SEVERITY_NAME
        tg.project = project
        tg.save

        TagGroup::SEVERITY_DEFAULT_TAG_NAMES.each do |tag_name|
          tag = Tag.new
          tag.tag_group = tg
          tag.project = project
          tag.name = tag_name
          tag.save
        end
      end

      remove_column :projects, :approvals
      remove_column :projects, :areas
      remove_column :projects, :boards
      remove_column :projects, :severities
    end
  end
end
