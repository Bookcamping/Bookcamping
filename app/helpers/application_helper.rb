module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption)
  end

  def lists_div(size, &block)
    content_tag(:div, content_tag(:div, :class => "lists", :style => "width: #{size * 380}px;", &block), :class => 'container')
  end

  def render_info
    render 'layouts/intro'
  end
end
