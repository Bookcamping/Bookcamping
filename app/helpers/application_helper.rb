module ApplicationHelper
  def title(caption)
    content_for(:title) {caption}
    content_tag(:h1, caption)
  end
end
