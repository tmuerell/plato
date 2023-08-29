require 'rails_helper'

RSpec.feature "Inbox Handling", type: :feature do
  before :each do
    @project = create(:project)
    @other_project = create(:project)
    @user1 = create(:user, roles: [ "Admin" ], current_project: @project)
    @customer_project = create(:customer_project, project: @project)
    @area_tag_group = create(:tag_group, name: 'Area', project: @project)
    @board_tag_group = create(:tag_group, name: 'Board', project: @project)
    @critical_board = create(:tag, tag_group: @board_tag_group, name: 'Critical', project: @project)
    @area_tag = create(:tag, tag_group: @area_tag_group, name: 'Backlog', project: @project)
    @area_tag2 = create(:tag, tag_group: @area_tag_group, name: 'Area 51', project: @other_project)
    @ticket = create(:ticket, title: 'Ganz wichtig', priority: :high, customer_project: @customer_project, status: :new, project: @project)
  end

  it "allows me to create a ticket" do
    sign_in_as(@user1)

    click_on "Inbox"

    expect(current_path).to match('/tickets/inbox')
    expect(page).to have_content 'Ganz wichtig'
    expect(page).to have_no_content 'Area 51'

    click_on "📗 Backlog"

    expect(current_path).to match('/tickets/inbox')
    #expect(page).to not_have_content 'Ganz wichtig'
  end
end
