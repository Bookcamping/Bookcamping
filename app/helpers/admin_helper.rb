module AdminHelper
  def admin_title(resource_class, title = nil)
    title ||= "#{resource_class.name}s"
    count = resource_class.send(:count)
    content_for(:title) { title }
    content_tag(:h1, raw("#{title} <small>(#{count})</small>"))
  end
end
