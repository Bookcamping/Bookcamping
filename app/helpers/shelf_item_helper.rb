module ShelfItemHelper
  def render_shelf_items(shelf)
    locals = { shelf_items: shelf.shelf_items, shelf: shelf }
    render 'shelf_items/shelf_items', locals: locals
  end
end
