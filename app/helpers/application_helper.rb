module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption)
  end

  def markdown(text, limit = nil)
    text = '' if text.blank?
    text =  truncate(text, :length => limit) if limit.present?
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    content_tag(:div, Redcarpet.new(text, *options).to_html.html_safe, :class => 'markdown')
  end

  # TRANSLATED COLLECTION
  def tc(prefix, collection)
    collection.map do |item|
      I18n.t "#{prefix}.#{item}"
    end
  end


  def current_model
    current_camp.model_name
  end
end
