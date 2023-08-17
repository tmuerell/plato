require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before :each do
    @project = build(:project, workflow: {
      states: {
        "new": {
          initial: true,
          transitions: {
            "in_progress": {}
          }
        },
        "in_progress": {
          transitions: {
            "done": {}
          }
        },
        "done": {}
      }
    })
  end

  it "correctly handles the states" do
    ticket = build(:ticket, project: @project)

    expect(ticket.status).to eq("new")
    expect(ticket.valid_transitions(nil)).to eq(["in_progress"])

  end
end
