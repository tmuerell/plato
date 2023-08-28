class Project < ApplicationRecord
  has_many :user_project_roles
  has_many :customer_projects
  has_many :tags
  has_many :tickets

  serialize :workflow, JSON

  validate :validate_workflow

  def sla_for(status)
    return unless workflow.present? || workflow["states"].present?
    return unless workflow["states"][status]["sla"].present?
    workflow["states"][status]["sla"]
  end

  def calculate_sla_status(status, duration_in_seconds)
    sla = sla_for(status)
    minutes = duration_in_seconds / 60

    return :none unless sla.present? && sla.count > 0
    if sla.count == 1
      if minutes > sla[0].to_i
        :warning
      else
        :ok
      end
    elsif sla.count > 1
      if minutes > sla[1].to_i
        :error
      elsif minutes > sla[0].to_i
        :warning
      else
        :ok
      end
    else
      :none
    end
  end

  def init_state
    return unless workflow.present? || workflow["states"].present?

    workflow["states"].each { |_k, v| v["initial_state"].present? && v["initital_state"] }.first[0]
  end

  def end_states
    return [] unless workflow.present? || workflow["states"].present?

    workflow["states"].filter_map do |k, v|
      if v["transitions"].nil? || v["transitions"].empty?
        k
      end
    end
  end

  def states
    workflow["states"].keys
  end

  def approval_tags
    Tag.where(project_id: id)
       .joins(:tag_group)
       .where('tag_groups.name = ?', TagGroup::APPROVAL_NAME)
  end

  def area_tags
    Tag.where(project_id: id)
       .joins(:tag_group)
       .where('tag_groups.name = ?', TagGroup::AREA_NAME)
  end

  def board_tags
    Tag.where(project_id: id)
       .joins(:tag_group)
       .where('tag_groups.name = ?', TagGroup::BOARD_NAME)
  end

  def severity_tags
    Tag.where(project_id: id)
       .joins(:tag_group)
       .where('tag_groups.name = ?', TagGroup::SEVERITY_NAME)
  end

  def value_tags
    Tag.where('tags.project_id = ? AND tags.value_type IS NOT NULL', id)
  end

  protected

  def validate_workflow
    init_state_found = false

    states = workflow["states"]

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
