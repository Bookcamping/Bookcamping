class BookmarksController < ApplicationController
  respond_to :js, :json

  expose(:book) { current_camp.books.find params[:book_id]}
  expose(:bookmarks) { book.bookmarks }
  expose(:bookmark)

  def create
    authorize! :create, bookmark

    bookmark.user = current_user
    bookmark.camp = current_camp
    bookmark.name = params[:mark] if params[:mark]

    previous = book.bookmarks.previous(bookmark.name, bookmark.user).first
    if previous
      bookmark.message = t('bookmarks.notice.already_exists')
      bookmark.count = book.bookmark_count(bookmark.name)
    else
      bookmark.message = t("bookmarks.notice.create.#{bookmark.name}") if bookmark.save
      bookmark.count = book.bookmark_count(bookmark.name) + 1
    end

    respond_with bookmark, :location => book
  end


end
