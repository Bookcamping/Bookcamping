class ApplicationPresenter < BasePresenter
  def raw(text)
    text.html_safe
  end

  def renderer
    options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  end

  def markdown(text, limit = nil)
    text = '' if text.blank?
    text = truncate(text, :length => limit) if limit.present?
    # REMOVED_OPTIONS: :filter_html,
    options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    rendered = renderer.render(text).html_safe
    "<div class='markdown'>#{rendered}</div>".html_safe
  end

end
