module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end

  def project_role?(project, role)
    return true if current_user.admin?
    return false unless project

    r = role.is_a?(Array) ? role : [ role.to_s ]
    project.user_project_roles.where(user_id: current_user.id, role: r.map(&:to_s)).count.positive?
  end
end
