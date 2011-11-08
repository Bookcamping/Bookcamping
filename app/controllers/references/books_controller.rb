class References::BooksController < ApplicationController
  expose(:books) { current_camp.books }
  expose(:book)

  def show

  end
end

