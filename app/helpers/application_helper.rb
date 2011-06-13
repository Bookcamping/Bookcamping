# encoding: utf-8

module ApplicationHelper
  def title(caption, tag = :h1)
    content_for(:title) { caption }
    content_tag(tag, caption.mb_chars.upcase)
  end

  def render_info

  end

  def lists_div(size, &block)
    content_tag(:div, content_tag(:div, :class => "lists", :style => "width: #{size * 380}px;", &block), :class => 'container')
  end

  def sidebar(partial = 'sidebar')
    content_for(:sidebar) { render partial }
  end

  def iconic(symbol, label = '')
    content_tag(:span, '', :class => "iconic #{symbol}") + label.to_s
  end

  def current_model
    current_camp.model_name
  end

end
