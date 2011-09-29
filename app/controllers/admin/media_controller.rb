class Admin::MediaController < Admin::ResourceController
  defaults :resource_class => Media, :collection_name => 'medias', :instance_name => 'media'

  protected
  def begin_of_association_chain
    current_camp
  end

end
