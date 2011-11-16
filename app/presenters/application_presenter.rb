class ApplicationPresenter < BasePresenter
  def markdown(text, limit = nil)
    text = '' if text.blank?
    text = truncate(text, :length => limit) if limit.present?
    # REMOVED_OPTIONS: :filter_html,
    options = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    h.content_tag(:div, Redcarpet.new(text, *options).to_html.html_safe, :class => 'markdown')
  end

end
