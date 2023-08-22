require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before :each do
    @project = build(:project, workflow: {
      states: {
        "new": {
          sla: [ 10 ],
          initial: true,
          transitions: {
            "in_progress": {}
          }
        },
        "in_progress": {
          sla: [ 10, 12 ],
          transitions: {
            "done": {}
          }
        },
        "done": {}
      }
    })
  end

  it "correctly handles the states" do
    ticket = build(:ticket, project: @project, last_transition_at: Time.now - 12.minutes)

    expect(ticket.status).to eq("new")
    expect(ticket.valid_transitions(nil)).to eq(["in_progress"])
    expect(ticket.sla_status).to eq(:warning)
  end

  it "correctly handles the states" do
    ticket = build(:ticket, status: "in_progress", project: @project, last_transition_at: Time.now - 15.minutes)

    expect(ticket.status).to eq("in_progress")
    expect(ticket.sla_status).to eq(:error)
  end
end
