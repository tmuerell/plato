module TagsHelper
  def render_tag(tag)
    content_tag(:span, class: 'badge rounded-pill bg-secondary') do
      link_to_tag(tag)
    end
  end

  def link_to_tag(tag, html_options = nil, &block)
    if tag.board?
      link_to(emojified(tag), board_path(tag), html_options, &block)
    else
      link_to(emojified(tag), tag, html_options, &block)
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
