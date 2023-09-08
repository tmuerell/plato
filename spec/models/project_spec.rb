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

  it "correctly determines the required values" do
    project = build(:project, workflow: {
      states: {
        "new": {
          initial: true,
          required_values: [
            "foo"
          ],
          transitions: {
            "in_progress": {
              "required_values": [
                "bar"
              ]
            }
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

    expect(project.required_values_for_transition("new")).to eq(["foo"])
    expect(project.required_values_for_transition("new", "in_progress")).to eq(["bar"])
  end

  it "correctly determines if approval is needed for transition" do
    project = build(:project, workflow: {
      states: {
        "new": {
          initial: true,
          required_values: [
            "foo"
          ],
          transitions: {
            "in_progress": {
              "required_values": [
                "bar"
              ],
              "needs_approval": true
            }
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

    expect(project.needs_approval_for_transition?("new")).to eq(false)
    expect(project.needs_approval_for_transition?("new", "in_progress")).to eq(true)
  end
end
