module TagsHelper
  def render_tag(tag)
    content_tag(:span, class: 'badge rounded-pill bg-secondary') do
      if tag.is_board
        link_to("📋 #{truncate(tag.name)}", tag)
      elsif tag.is_area
        link_to("📗 #{truncate(tag.name)}", tag)
      else
        link_to tag.name, tag
      end
    end
  end
end
