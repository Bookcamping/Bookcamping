module Admin::ApplicationHelper
  def admin_title(resource_class)
    count = resource_class.send(:count)
    content_for(:title) { "#{resource_class.name}s" }
    content_tag(:h1, raw("#{resource_class.name}s <small>#{count}</small>"))
  end
end
