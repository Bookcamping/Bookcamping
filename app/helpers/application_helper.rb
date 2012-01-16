module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption)
  end

  def renderer
    options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  end

  def markdown(text, limit = nil)
    text = '' if text.blank?
    text = truncate(text, :length => limit) if limit.present?
    # REMOVED_OPTIONS: :filter_html,
    content_tag(:div, renderer.render(text).html_safe, :class => 'markdown')
  end

  # TRANSLATED COLLECTION
  def tc(prefix, collection)
    collection.map do |item|
      [I18n.t("#{prefix}.#{item}"), item]
    end
  end

  # BETA SECTIONS
  def beta?
    current_user and current_user.beta?
  end

  def beta(&block)
    with_output_buffer(&block) if beta?
  end

  def beta_div(&block)
    content_tag(:div, class: 'beta', &block) if beta?
  end

  # Presenters: see http://railscasts.com/episodes/287-presenters-from-scratch
  def present(object, options = {}, klass = nil)
    if object
      klass ||= "#{object.class}Presenter".constantize
      presenter = klass.new(object, options, self)
      yield presenter if block_given?
      presenter
    end
  end

  def render_presenter(klass, object, options = {})
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, options, self)
    presenter.render
  end


  def current_model
    current_camp.model_name
  end
end
