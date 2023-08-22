module TagsHelper
  def render_tag(tag)
    content_tag(:span, class: 'badge rounded-pill bg-secondary') do
      link_to(emojified(tag), tag)
    end
  end

  def emojified(tag)
    if tag.board?
      "📋 #{truncate(tag.name)}"
    elsif tag.area?
      "📗 #{truncate(tag.name)}"
    else
      tag.name
    end
  end
end
