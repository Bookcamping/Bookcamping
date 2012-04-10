module ReferencesHelper
  def render_reference(reference, options = {})
    locals = options.reverse_merge({reference: reference, shelf: nil,
                                    background_color: '#efefef'})
    render partial: 'references/reference', locals: locals
  end

  def render_references(references, background, shelf = nil)
    locals = {references: references, background_color: background,
              shelf: shelf, render_mode: shelf.try(:render_mode) }
    render :partial => 'references/references', locals: locals
  end

  def render_reference_item(reference, reference_link, background = 'gray')
    render partial: 'shared/references/reference_item', locals:
      {reference: reference, reference_link: reference_link, background_color: background}
  end

  def license_type_icon(reference)
    name = reference.license.license_type
    image_tag("license_icons/#{name}.png", :class => 'license-type')
  end


end

