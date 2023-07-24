require 'rails_helper'

RSpec.feature "TicketCreations", type: :feature do
  before :each do
    @project = create(:project)
    @user1 = create(:user, roles: [ "Admin" ], current_project: @project)
    @customer_project = create(:customer_project)
  end

  it "allows me to create a ticket" do
    sign_in_as(@user1)

    click_on "Neues Ticket"

    fill_in 'Titel', with: 'Das ist ein lustiges Ticket'
    select 'High', from: 'Priorität'
    select @customer_project.name, from: 'Kundenprojekt'
    click_on "Create Ticket"

    expect(page).to have_content 'Ticket was successfully created'
  end
end
