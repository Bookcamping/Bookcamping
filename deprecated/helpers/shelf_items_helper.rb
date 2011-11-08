module ShelfItemsHelper
  def render_shelf_items(shelf_items)
    render :partial => 'shelf_items/shelf_items', :locals => {:shelf_items => shelf_items}
  end
end
