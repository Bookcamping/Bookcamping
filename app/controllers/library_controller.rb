class LibraryController < ApplicationController

  expose(:shelves) { current_camp.shelves }
  LIMIT = 20
  expose(:ultimas_books) { current_camp.books.order('id DESC').limit(LIMIT) }
  expose(:comentadas_books) { current_camp.books.where('comments_count > 0').order('comments_count DESC').limit(LIMIT) }
  expose(:valoradas_books) { current_camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(LIMIT) }
  expose(:deseadas_books) { current_camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(LIMIT) }

  def index

  end

end
