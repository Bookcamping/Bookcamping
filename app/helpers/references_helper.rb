module ReferencesHelper
  def render_references(references, background, shelf = nil)
    render :partial => 'shared/references/references', :locals => {:references => references, :background => background, :shelf => shelf}
  end

  def render_reference_item(reference, reference_link, background = 'gray')
    render partial: 'shared/references/reference_item', locals:
        {reference: reference, reference_link: reference_link, background_color: background}
  end

  def license_type_icon(reference)
    name = reference.license.license_type
    image_tag("/images/ui3/license_icons/#{name}.png", :class => 'license-type')
  end


end

