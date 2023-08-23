module TagsHelper
  def render_tag(tag)
    content_tag(:span, class: 'badge rounded-pill bg-secondary') do
      if tag.board?
        link_to(emojified(tag), board_path(tag))
      else
        link_to(emojified(tag), tag)
      end
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
