require 'rails_helper'

RSpec.feature "User roles", type: :feature do
  before :each do
    @project1 = create(:project, name: "Stinknormal")
    @project2 = create(:project, name: "Area 51")
    @user1 = create(:user, roles: [ "User" ], current_project: @project1)
    @user2 = create(:user)
    @ticket1 = create(:ticket, project: @project1, title: 'Ticket stinknormal')
    @ticket2 = create(:ticket, project: @project2, title: 'Ticket Area 51', creator: @user2)
    create(:user_project_role, user: @user1, project: @project1, role: :user)
  end

  it "allows me to see the projects I should see" do
    sign_in_as(@user1)

    visit '/projects'

    expect(page).to have_content 'Stinknormal'
    expect(page).to have_no_content 'Area 51'

    visit '/tickets'

    expect(page).to have_content 'Ticket stinknormal'
    expect(page).to have_no_content 'Ticket Area 51'
  end
end
