module ShelvesHelper
  def tr_for_shelf(shelf, &block)
    render partial: 'shelves/tr_for_shelf',
           locals: {shelf: shelf, content: capture(&block) }
  end

  def shelf_background(shelf)
    color = shelf.color? ? shelf.color : '#db533d'
    "background-color: #{color}"
  end


  def render_shelves(shelves, reference = nil)
    render partial: 'shared/shelves/shelves', locals:
        {shelves: shelves, reference: reference}
  end

  def render_shelf(shelf, shelf_link)
    render partial: 'shared/shelves/shelf', locals:
        {shelf: shelf, shelf_link: shelf_link}
  end

  def render_shelf_header(shelf)
    render partial: 'shared/shelves/shelf_header', locals:
        {shelf: shelf}
  end
end

