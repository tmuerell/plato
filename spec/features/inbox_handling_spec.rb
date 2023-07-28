require 'rails_helper'

RSpec.feature "Inbox Handling", type: :feature do
  before :each do
    @project = create(:project)
    @user1 = create(:user, roles: [ "Admin" ], current_project: @project)
    @customer_project = create(:customer_project)
    @critical_board = create(:tag, name: 'Critical', is_board: true)
    @area_tag = create(:tag, name: 'Backlog', is_area: true)
    @ticket = create(:ticket, title: 'Ganz wichtig', priority: :high, customer_project: @customer_project, status: :new, project: @project)
  end

  it "allows me to create a ticket" do
    sign_in_as(@user1)

    click_on "Inbox"

    expect(current_path).to match('/tickets/inbox')
    expect(page).to have_content 'Ganz wichtig'

    click_on "📗 Backlog"

    expect(current_path).to match('/tickets/inbox')
    #expect(page).to not_have_content 'Ganz wichtig'
  end
end