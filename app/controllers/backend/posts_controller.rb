class Backend::PostsController < Backend::ResourceController
  protected
  def begin_of_association_chain
    current_camp
  end
end
