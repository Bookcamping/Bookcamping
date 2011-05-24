module ApplicationHelper
  def title(caption)
    content_for(:title) {caption}
    content_tag(:h1, caption)
  end

  def lists_div(size, &block)
    content_tag(:div, content_tag(:div, :class => "lists", :style => "width: #{size * 440}px;", &block), :class => 'container')
  end
end
