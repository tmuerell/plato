require 'rails_helper'

RSpec.feature "TicketCreations", type: :feature do
  before :each do
    @project = create(:project)
    @user1 = create(:user, roles: ["User"], current_project: @project)
    create(:user_project_role, user: @user1, project: @project, role: 'user')
  end

  it "allows me to create a ticket" do
    sign_in_as(@user1)

    within find("nav") do
      click_on "New ticket"
    end

    fill_in 'Title', with: 'Das ist ein lustiges Ticket'
    click_on "Create Ticket"

    expect(page).to have_content 'Ticket was successfully created'
  end
end
