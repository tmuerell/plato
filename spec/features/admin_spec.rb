require 'rails_helper'

RSpec.feature "As an admin", type: :feature do
  before :each do
    @project = create(:project)
    @other_project = create(:project)
    @admin = create(:user, roles: [ "Admin" ], current_project: @project)
    @customer_project = create(:customer_project, project: @project)
    @area_tag_group = create(:tag_group, name: 'Area', project: @project)
    @board_tag_group = create(:tag_group, name: 'Board', project: @project)
    @critical_board = create(:tag, tag_group: @board_tag_group, name: 'Critical', project: @project)
    @area_tag = create(:tag, tag_group: @area_tag_group, name: 'Backlog', project: @project)
    @area_tag2 = create(:tag, tag_group: @area_tag_group, name: 'Area 51', project: @other_project)
    @ticket = create(:ticket, title: 'Ganz wichtig', customer_project: @customer_project, status: :new, project: @project)
  end

  it "allows me to see the projects page" do
    sign_in_as(@admin)

    click_on "Projects"

    expect(current_path).to match('/projects')
    expect(page).to have_content @project.name
  end
end
