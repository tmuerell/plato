require 'rails_helper'

RSpec.describe Project, type: :model do
  it "correctly validates the workflow" do
    project = build(:project, workflow: {
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

    expect(project).to be_valid
    expect(project.init_state).to eq("new")
  end

  it "rejects a workflow with state misconfiguration" do
    project = build(:project, workflow: {
      states: {
        "new": {
          initial: true,
          transitions: {
            "in_progress": {}
          }
        },
        "in_progress": {
          transitions: {
            "donex": {}
          }
        },
        "done": {}
      }
    })

    expect(project).to be_invalid
  end

  it "rejects a workflow with missing init state" do
    project = build(:project, workflow: {
      states: {
        "new": {
        },
        "in_progress": {
        },
      }
    })

    expect(project).to be_invalid
  end

  it "correctly determines the end states" do
    project = build(:project, workflow: {
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

    expect(project.end_states).to eq(["done"])
  end

end
