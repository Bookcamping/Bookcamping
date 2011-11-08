module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption)
  end

  def markdown(text, limit = nil)
    text = '' if text.blank?
    text = truncate(text, :length => limit) if limit.present?
    # REMOVED_OPTIONS: :filter_html,
    options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    content_tag(:div, Redcarpet.new(text, *options).to_html.html_safe, :class => 'markdown')
  end

  # TRANSLATED COLLECTION
  def tc(prefix, collection)
    collection.map do |item|
      [I18n.t("#{prefix}.#{item}"), item]
    end
  end

  # Presenters: see http://railscasts.com/episodes/287-presenters-from-scratch
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end


  def current_model
    current_camp.model_name
  end
end
