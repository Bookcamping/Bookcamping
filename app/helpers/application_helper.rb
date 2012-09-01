module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption)
  end

  def renderer
    unless @renderer
      options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
      @renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    end
    @renderer
  end

  def markdown(text, limit = nil)
    text = ' ' if text.blank?
    text = truncate(text, :length => limit) if limit.present?
    rendered = renderer.render(text)
    content_tag(:div, (rendered+'<br/>').html_safe, :class => 'markdown')
  end

  def md2html(text)
    renderer.render(text).gsub(/h2/, 'h3').gsub(/h1/, 'p')
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
    #content_tag(:div, class: 'beta', &block) if beta?
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

  def simple_debug(model)
    debug(model) if Rails.env.development?
  end
end
