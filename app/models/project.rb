class Project < ApplicationRecord
  has_many :user_project_roles
  serialize :workflow, JSON

  validate :validate_workflow

  def init_state
    return unless workflow.present? || workflow["states"].present?
    workflow["states"].each { |k,v| v["initial_state"].present? && v["initital_state"] }.first[0]
  end

  def states
    workflow["states"].keys
  end

  protected

  def validate_workflow
    init_state_found = false

    for key, value in states
      if value["initial"].present? && value["initial"]
        init_state_found = true
      end
      if value["transitions"].present?
        for transition in value["transitions"].keys
          unless states.include?(transition)
            errors.add :workflow, "State #{transition} not found in workflow"
          end
        end
      end
    end

    unless init_state_found
      errors.add :workflow, "Init state not found in workflow"
    end
  end

end
