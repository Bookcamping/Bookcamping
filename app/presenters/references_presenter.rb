# ReferencesPresenter
#
# Ayuda a renderizar una colección de referencias
#
class ReferencesPresenter < ApplicationPresenter
  presents :references

  def color
    if @options[:background_color].present?
      @options[:background_color]
    elsif @options[:shelf].present?
      @options[:shelf].color
    else
      '#efefef'
    end
  end

  def render
    h.render partial: 'shared/references/references', locals: {presenter: self}
  end

  def url_for(reference)
    @url_builder ||= @options[:url_builder]
    @url_builder ||= self
    @url_builder.build_url_for(reference)
  end

  def build_url_for(reference)
    [reference]
  end

  def title
    raw("#{self[:title]}<small> #{references.size}</small>")
  end

  def user_shelves_names
    h.current_user.user_shelves.order(:name).map(&:name)
  end
end