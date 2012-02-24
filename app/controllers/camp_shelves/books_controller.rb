# Controller for Books belonging to CampShelves
class CampShelves::BooksController < Shared::BooksController
  expose(:camp_shelf) { CampShelf.find_by_slug(params[:camp_shelf_id]) || CampShelf.find(params[:camp_shelf_id]) }
  expose(:shelf) { camp_shelf }
  expose(:pajax?) { request.headers['X-PJAX'].present? }
  expose(:current_camp) { camp_shelf.camp }
  
  def show
    if pajax?
      render action: 'show_pjax', layout: false
    end
  end

  def new
    book.include_in_shelf_id = camp_shelf.id
    book.title = params[:title]
  end

  expose(:reference_title) { params[:title] }
  expose(:search) { Search.new(:books, current_camp.books, params[:title]) }
  def select
  end

  def add
    book = Book.find params[:id]
    camp_shelf.add_book(book, current_user)
    redirect_to camp_shelf
  end


end

