class BookListsController < ApplicationController
  expose(:book_lists) { BookList.all }

  def index

  end
end
