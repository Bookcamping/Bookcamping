# ReferencesPresenter
#
# Ayuda a renderizar una colección de referencias
#
class ReferencesPresenter < ApplicationPresenter
  presents :references

  def render
    h.render partial: 'shared/references/references', locals: {presenter: self}
  end

  def url_for(reference)
    [reference]
  end
end